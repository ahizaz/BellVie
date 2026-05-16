import 'package:bellevie/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class DiscountPartner extends StatefulWidget {
  const DiscountPartner({super.key});

  @override
  State<DiscountPartner> createState() => _DiscountPartnerState();
}

class _DiscountPartnerState extends State<DiscountPartner> {

  HomeController homeController = HomeController();
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Row(
            children: [
              Text(
                "Discount Partner",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12,),
          Obx((){
            return homeController.isLoading.value == false ? CircularProgressIndicator() :
              Container(
              height: 120,
              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(10)
              ),

              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: homeController.discountPartnerData.value!.results!.length,
                itemBuilder: (context, index){
                  return Container(
                    margin: EdgeInsets.only(right: 12),
                    height: 100,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text(
                        "${homeController.discountPartnerData.value!.results![index].name}"
                    ),
                  );
                },
              ),
            );
          })
        ],
      );

  }
}
