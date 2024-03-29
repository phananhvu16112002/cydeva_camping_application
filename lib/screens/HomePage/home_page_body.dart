import 'package:carousel_slider/carousel_slider.dart';
import 'package:cydeva_application/common/Colors/app_colors.dart';

import 'package:cydeva_application/common/bases/custom_text.dart';
import 'package:cydeva_application/models/category_model.dart';
import 'package:cydeva_application/models/guilde_model.dart';
import 'package:cydeva_application/models/recommend_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cydeva_application/extensions/build_context.dart';
import 'package:image_picker/image_picker.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
   XFile? file;
  // late AttendanceForm attendanceForm;
  final ImagePicker _picker = ImagePicker();
  TextEditingController searchController = TextEditingController();
  List<String> imageUrls = [
    'assets/images/image.png',
    'assets/images/image2.png',
    'assets/images/image3.png',
  ];

  List<GuideModel> listGuideModel = [
    GuideModel(
        title: 'Enjoy your trip',
        description: 'Tips to help you have memory',
        imgPath: 'guide',
        subTitle: ''),
    GuideModel(
        title: 'Tool preparation',
        description: 'What tools you need to prep',
        imgPath: 'guide3',
        subTitle: ''),
    GuideModel(
        title: 'Travel articles',
        description: 'Tips to help you have memoryasdasdasdasdsadadasdas',
        imgPath: 'guide4',
        subTitle: ''),
    GuideModel(
        title: '', description: '', imgPath: 'guide2', subTitle: 'Make a plan'),
  ];

  List<Category> listCategory = [
    Category(title: 'Lake', imagePath: 'category1'),
    Category(title: 'Mountain', imagePath: 'category1')
  ];

  ScrollController controller = ScrollController();

  List<Recommend> listRecommend = [
    Recommend(
        name: 'Lockness Lake',
        location: 'USA',
        imgPath: 'recommend1',
        viewers: '4.8k'),
    Recommend(
        name: 'Ice Mountain',
        location: 'Russia',
        imgPath: 'recommend2',
        viewers: '4.8k'),
  ];
  int currentIndex = 0;

  CarouselController carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral02,
      body: SizedBox(
        width: context.screenSize.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [appBar(), body()],
          ),
        ),
      ),
    );
  }

  Widget body() {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              carousel(),
              const SizedBox(
                height: 10,
              ),
              category(),
              const SizedBox(
                height: 16,
              ),
              recommend(),
              const SizedBox(
                height: 8,
              ),
              guide(),
            ],
          ),
        ));
  }

  Padding guide() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
              message: 'Guild to help you',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.neutral09),
          MasonryGridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: listGuideModel.length,
            itemBuilder: (context, index) {
              GuideModel guideModel = listGuideModel[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.asset(
                          'assets/images/${guideModel.imgPath}.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 80,
                        left: 25,
                        child: CustomText(
                            message: guideModel.subTitle,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.neutralWhite),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  CustomText(
                    message: guideModel.title,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.neutral08,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    guideModel.description,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.neutral08,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  Container recommend() {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Recommend for you',
                    style: TextStyle(
                        color: AppColors.neutral09,
                        fontSize: 20,
                        fontWeight: FontWeight.w700)),
              ],
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: listRecommend.length,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(top: 8),
                itemBuilder: (context, index) {
                  Recommend recommend = listRecommend[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Container(
                      width: 400,
                      height: 230,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  'assets/images/${recommend.imgPath}.png'))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              recommend.name,
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: AppColors.colorText,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                SvgPicture.asset('assets/icons/location.svg'),
                                const SizedBox(width: 2),
                                Text(
                                  recommend.location,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.colorText,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                SvgPicture.asset('assets/icons/star.svg'),
                                const SizedBox(width: 2),
                                Text(
                                  '${recommend.viewers} (reviewer)',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.colorText,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  Container category() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Categories',
                    style: TextStyle(
                        color: AppColors.neutral09,
                        fontSize: 20,
                        fontWeight: FontWeight.w700)),
                Row(
                  children: [
                    const Text('See more',
                        style: TextStyle(
                            color: AppColors.neutral06,
                            fontSize: 12,
                            fontWeight: FontWeight.w400)),
                    const SizedBox(
                      width: 4,
                    ),
                    SvgPicture.asset('assets/icons/more.svg',
                        color: AppColors.neutral06),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 100,
            child: Row(
              children: [
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    controller: controller,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 24),
                    itemCount: listCategory.length,
                    itemBuilder: (context, index) {
                      Category e = listCategory[index];
                      return Stack(
                        children: [
                          Container(
                            width: 200,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/${e.imagePath}.png',
                                    ),
                                    fit: BoxFit.cover)),
                          ),
                          Container(
                            height: 100,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.6),
                                  Colors.transparent
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 40.0, bottom: 40.0, left: 16),
                              child: CustomText(
                                  message: e.title,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.neutralWhite),
                            ),
                          )
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 16,
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container carousel() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Hot Camp',
                    style: TextStyle(
                        color: AppColors.primary3,
                        fontSize: 20,
                        fontWeight: FontWeight.w700)),
                Row(
                  children: [
                    const Text('See more',
                        style: TextStyle(
                            color: AppColors.primary3,
                            fontSize: 12,
                            fontWeight: FontWeight.w400)),
                    const SizedBox(
                      width: 4,
                    ),
                    SvgPicture.asset('assets/icons/more.svg')
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          CarouselSlider(
            carouselController: carouselController,
            options: CarouselOptions(
              aspectRatio: 14.2 / 10.3,
              viewportFraction: 0.55,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              // autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
            items: imageUrls.map((e) {
              return Builder(
                builder: (BuildContext context) {
                  return currentIndex == imageUrls.indexOf(e)
                      ? Container(
                          decoration: const BoxDecoration(
                            color: AppColors.primary3,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8)),
                                  child: Image.asset(
                                    e,
                                    width: 230,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Himalayaa mountain peak',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.colorText,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/icons/location.svg'),
                                    const SizedBox(width: 2),
                                    const Text(
                                      'Himalayan',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: AppColors.colorText,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/star.svg'),
                                    const SizedBox(width: 2),
                                    const Text(
                                      '4.5  ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.colorText,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      : Stack(
                          children: [
                            Container(
                              width: 180,
                              height: 250,
                              decoration: const BoxDecoration(
                                color: AppColors.primary3,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 180,
                                      height: 150,
                                      child: Image.asset(
                                        e,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Text(
                                        'Himalayaa mountain peak',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: AppColors.colorText,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icons/location.svg'),
                                          const SizedBox(width: 2),
                                          const Text(
                                            'Himalayan',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: AppColors.colorText,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 250,
                              width: 180,
                              color: Colors.white.withOpacity(0.5),
                            )
                          ],
                        );
                },
              );
            }).toList(),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget appBar() {
    return Container(
      height: 190,
      width: double.infinity,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16)),
          image: DecorationImage(
            image: AssetImage(
              'assets/images/appbar.png',
            ),
            fit: BoxFit.cover,
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 55,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        message: "Let's start a new adventure",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.neutralWhite),
                    CustomText(
                        message: "Tasha",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.neutralWhite)
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/notice.svg',
                        color: AppColors.neutralWhite),
                    const SizedBox(
                      width: 9,
                    ),
                    Container(
                      width: 42,
                      height: 42,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Image.asset('assets/images/avatar.png'),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    // width: 290,
                    height: 55,
                    decoration: BoxDecoration(
                        color: AppColors.neutralWhite,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(32)),
                        border: Border.all(color: AppColors.borderColor)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.spaceA,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        SvgPicture.asset(
                          'assets/icons/search.svg',
                          fit: BoxFit.none,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                                message: 'Where are you going',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.neutral06),
                            SizedBox(
                              height: 4,
                            ),
                            CustomText(
                                message: 'Explore new lands, conquer big...',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.neutral05),
                          ],
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        SvgPicture.asset(
                          'assets/icons/mic.svg',
                          fit: BoxFit.none,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(26)),
                        border: Border.all(color: AppColors.neutral05)),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/filter.svg',
                        fit: BoxFit.none,
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget customTextFormField(
    double width,
    double height,
    bool readOnly,
    TextEditingController controller,
    TextInputType textInputType,
    bool obscureText,
    Color colorHintText,
    SvgPicture prefixIcon,
    SvgPicture suffixIcon,
    String hintText,
  ) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(32)),
      child: TextFormField(
        readOnly: readOnly,
        controller: controller,
        keyboardType: textInputType,
        style: const TextStyle(
            color: AppColors.primaryText,
            fontWeight: FontWeight.normal,
            fontSize: 15),
        obscureText: obscureText,
        decoration: InputDecoration(
            hintStyle: TextStyle(color: colorHintText, fontSize: 16),
            border: const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: AppColors.borderColor),
                borderRadius: BorderRadius.all(Radius.circular(32))),
            contentPadding: const EdgeInsets.all(20),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            hintText: hintText,
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32)),
                borderSide: BorderSide(width: 1, color: AppColors.borderColor)),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32)),
              borderSide: BorderSide(width: 1, color: AppColors.borderColor),
            )),
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        file = pickedFile;
      });
    }
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          const Text(
            'Choose Your Photo',
            style: TextStyle(fontSize: 20.0),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                icon: const Icon(Icons.camera),
                label: const Text('Gallery'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                icon: const Icon(Icons.camera),
                label: const Text('Gallery'),
              ),
              // const SizedBox(
              //   width: 10,
              // ),
              // ElevatedButton.icon(
              //   onPressed: () {
              //     takePhoto(ImageSource.gallery);
              //   },
              //   icon: const Icon(Icons.camera),
              //   label: const Text('Gallery'),
              // ),
            ],
          )
        ],
      ),
    );
  }
}
