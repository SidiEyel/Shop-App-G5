import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shop/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/user_model.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../login/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onboard_1.png',
      title: 'On Board 1 Title',
      body: 'On Board 1 body ',
    ),
    BoardingModel(
        image: 'assets/images/onboard_1.png',
      title: 'On Board 2 Title',
      body: 'On Board 2 body ',
    ),
    BoardingModel(
        image: 'assets/images/onboard_1.png',
      title: 'On Board 3 Title',
      body: 'On Board 3 body ',
    ),
  ];


  bool isLast=false;

  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value)
    {
      if(value){
        navigateTo(
          context: context,
          widget: LoginScreen(),
        );
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  late double width, height;
  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions:
        [
          defaultTextButton(
            function: ()
            {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                submit();
              });
            },
            text: 'skip',
          ),
        ],
      ),
      body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: height * .1,
                  decoration: const BoxDecoration(
                      color: secondColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(70.0,),
                      bottomRight: Radius.circular(70.0,),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: height * .9,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children:
                        [
                          Expanded(
                            child: PageView.builder(
                              physics: const BouncingScrollPhysics(),
                              controller: boardController,
                              onPageChanged: (int index)
                              {
                                if(index == boarding.length-1)
                                {
                                  setState(() {
                                    isLast = true;
                                  });
                                }else{
                                  setState(() {
                                    isLast = false;
                                  });
                                }

                              },

                              itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
                              itemCount: boarding.length,
                            ),
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          Row(
                            children:
                            [
                              SmoothPageIndicator(
                                controller: boardController,
                                effect: const ExpandingDotsEffect(
                                  dotColor: Colors.grey,
                                  activeDotColor: Colors.blue,
                                  dotHeight: 10,
                                  expansionFactor: 4,
                                  dotWidth: 10,
                                  spacing: 5.0,
                                ),
                                count: boarding.length,
                              ),
                              const Spacer(),
                              FloatingActionButton(
                                onPressed: ()
                                {
                                  if(isLast)
                                  {
                                    submit();
                                  }else{
                                    boardController.nextPage(
                                      duration: const Duration(
                                        milliseconds: 750,
                                      ),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                    );
                                  }
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              ),
             ],
        ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),
        ),
      ),
      Text(
        '${model.title}',
        style: const TextStyle(
          fontSize: 24.0,
        ),
      ),
      const SizedBox(
        height: 15.0,
      ),
      Text(
        '${model.body}',
        style: const TextStyle(
          fontSize: 16.0,
        ),
      ),
    ],
  );
}
