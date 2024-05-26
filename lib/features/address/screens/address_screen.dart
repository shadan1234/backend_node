import 'package:flutter/material.dart';
import 'package:node/constants/utils.dart';
import 'package:node/features/address/servcies/address_services.dart';
import 'package:node/providers/user_provider.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/custom_textfield.dart';
import '../../../constants/global_variable.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  final Future<PaymentConfiguration> _googlePayConfigFuture =
      PaymentConfiguration.fromAsset('gpay.json');
  final Future<PaymentConfiguration> _applePayConfigFuture =
      PaymentConfiguration.fromAsset('applepay.json');

  String addressToBeUsed = "";
  List<PaymentItem> paymentItems = [];
  final AddressServices addressServices = AddressServices();
  @override
  void dispose() {
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    paymentItems.add(PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price));
    super.initState();
  }

  void onApplePayResult(_) {}

  void onGooglePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveAddress(context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: double.parse(widget.totalAmount));
  }
  void onTappp(){
     if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveAddress(context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: double.parse(widget.totalAmount));
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;
    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
      } else {
        throw Exception('Please enter all the values');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'Error');
    }
    debugPrint(addressToBeUsed);
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    // context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'OR',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                        controller: flatBuildingController,
                        hintText: 'Flat,House no, Building'),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        controller: areaController, hintText: 'Area, Street'),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        controller: pincodeController, hintText: 'Pincode'),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        controller: cityController, hintText: 'Town/City'),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder<PaymentConfiguration>(
                  future: _applePayConfigFuture,
                  builder: (context, snapshot) => snapshot.hasData
                      ? ApplePayButton(
                          width: double.infinity,
                          style: ApplePayButtonStyle.whiteOutline,
                          height: 50,
                          paymentConfiguration: snapshot.data!,
                          paymentItems: paymentItems,
                          type: ApplePayButtonType.buy,
                          margin: const EdgeInsets.only(top: 15.0),
                          // onPaymentResult: onGooglePayResult,
                          loadingIndicator: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : const SizedBox.shrink()),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder<PaymentConfiguration>(
                  future: _googlePayConfigFuture,
                  builder: (context, snapshot) => snapshot.hasData
                      ? GooglePayButton(  
                          onPressed: () => payPressed(address),
                          height: 50,
                          width: double.infinity,
                          paymentConfiguration: snapshot.data!,
                          paymentItems: paymentItems,
                          type: GooglePayButtonType.buy,
                          margin: const EdgeInsets.only(top: 15.0),
                          onPaymentResult: onGooglePayResult,
                          loadingIndicator: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : const SizedBox.shrink()),

                      ElevatedButton(onPressed: (){onTappp();}, child: Text('Save Address and place order')),
                      ElevatedButton(onPressed: (){payPressed(address);}, child: Text('Save Address perform funct')),

            ],
          ),
        ),
      ),
    );
  }
}
