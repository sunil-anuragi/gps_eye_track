import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gps_software/screens/bottomBar/module/vehicleList/viewModel/vehicle_list_view_model.dart';
import 'package:gps_software/util/app_constant.dart';

class VehicleSearchBar extends StatefulWidget {
  const VehicleSearchBar({super.key});

  @override
  State<VehicleSearchBar> createState() => _VehicleSearchBarState();
}

class _VehicleSearchBarState extends State<VehicleSearchBar>
    with SingleTickerProviderStateMixin {
  late final VehicleListViewModel _viewModel;
  late final FocusNode _focusNode;
  late final AnimationController _animationController;
  late final Animation<double> _iconSlideAnimation;
  late final Animation<double> _fieldFadeAnimation;

  bool _isSearchActive = false;

  @override
  void initState() {
    super.initState();
    _viewModel = Get.find<VehicleListViewModel>();
    _focusNode = FocusNode();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _iconSlideAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _fieldFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.35, 1.0, curve: Curves.easeIn),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _activateSearch() async {
    if (_isSearchActive) {
      _focusNode.requestFocus();
      return;
    }

    setState(() => _isSearchActive = true);
    await _animationController.forward();
    if (mounted) {
      _focusNode.requestFocus();
    }
  }

  void _deactivateSearch() {
    if (!_isSearchActive) return;
    _focusNode.unfocus();
    _animationController.reverse().then((_) {
      if (mounted) {
        setState(() => _isSearchActive = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final carSectionWidth = 14.w + 20.r + 10.w;
    final searchIconSize = 20.r;
    final iconGap = 8.w;
    final sidePadding = 14.w;

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 8.h),
      child: GestureDetector(
        onTap: _activateSearch,
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: 48.h,
          decoration: BoxDecoration(
            color: AppColors.searchBgColor,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
                spreadRadius: 0,
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.10),
                blurRadius: 14,
                offset: const Offset(0, 6),
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 24,
                offset: const Offset(0, 12),
                spreadRadius: 2,
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final slideDistance = constraints.maxWidth -
                  carSectionWidth -
                  sidePadding -
                  searchIconSize;

              if (!_isSearchActive) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    14.w.sizeBoxFromWidth(),
                    Icon(
                      Icons.directions_car_outlined,
                      color: AppColors.grayColor,
                      size: searchIconSize,
                    ),
                    10.w.sizeBoxFromWidth(),
                    Expanded(
                      child: Text(
                        AppStrings.searchPlaceholder.tr,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'Poppins',
                          color: AppColors.grayColor,
                          height: 1.2,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.search,
                      color: AppColors.grayColor,
                      size: searchIconSize,
                    ),
                    14.w.sizeBoxFromWidth(),
                  ],
                );
              }

              return Stack(
                alignment: Alignment.centerLeft,
                clipBehavior: Clip.none,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      14.w.sizeBoxFromWidth(),
                      Icon(
                        Icons.directions_car_outlined,
                        color: AppColors.grayColor,
                        size: searchIconSize,
                      ),
                      10.w.sizeBoxFromWidth(),
                      SizedBox(width: searchIconSize + iconGap),
                      Expanded(
                        child: FadeTransition(
                          opacity: _fieldFadeAnimation,
                          child: TextField(
                            controller: _viewModel.searchController,
                            focusNode: _focusNode,
                            autofocus: false,
                            textAlignVertical: TextAlignVertical.center,
                            onTapOutside: (_) => _deactivateSearch(),
                            onSubmitted: (_) => _deactivateSearch(),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'Poppins',
                              color: AppColors.blackColor,
                              height: 1.2,
                            ),
                            decoration: InputDecoration(
                              hintText: AppStrings.searchPlaceholder.tr,
                              hintStyle: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: 'Poppins',
                                color: AppColors.grayColor,
                                height: 1.2,
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ),
                      14.w.sizeBoxFromWidth(),
                    ],
                  ),
                  AnimatedBuilder(
                    animation: _iconSlideAnimation,
                    builder: (context, child) {
                      return Positioned(
                        left: carSectionWidth +
                            (slideDistance * _iconSlideAnimation.value),
                        top: 0,
                        bottom: 0,
                        child: Center(child: child),
                      );
                    },
                    child: Icon(
                      Icons.search,
                      color: AppColors.grayColor,
                      size: searchIconSize,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
