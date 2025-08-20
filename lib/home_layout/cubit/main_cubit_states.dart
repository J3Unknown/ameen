import 'package:ameen/item_delivery_screen/data/address_data_model.dart';

abstract class MainCubitStates{}

final class MainInitState extends MainCubitStates{}

final class MainChangeNavigationBarIndexState extends MainCubitStates{}

final class MainPickItemDeliveryImagesLoadingState extends MainCubitStates{}

final class MainPickItemDeliveryImagesSuccessState extends MainCubitStates{}

final class MainGetProfileLoadingState extends MainCubitStates{}

final class MainGetProfileSuccessState extends MainCubitStates{}

final class MainGetProfileErrorState extends MainCubitStates{}

final class MainLogoutLoadingState extends MainCubitStates{}

final class MainLogoutSuccessState extends MainCubitStates{}

final class MainLogoutErrorState extends MainCubitStates{}

final class MainDeleteAccountLoadingState extends MainCubitStates{}

final class MainDeleteAccountSuccessState extends MainCubitStates{}

final class MainDeleteAccountErrorState extends MainCubitStates{}

final class MainGetCitiesLoadingState extends MainCubitStates{}

final class MainGetCitiesSuccessState extends MainCubitStates{}

final class MainGetCitiesErrorState extends MainCubitStates{}

final class MainGetRegionsLoadingState extends MainCubitStates{}

final class MainGetRegionsSuccessState extends MainCubitStates{}

final class MainGetRegionsErrorState extends MainCubitStates{}

final class MainGetHomeLoadingState extends MainCubitStates{}

final class MainGetHomeSuccessState extends MainCubitStates{}

final class MainGetCategoriesLoadingState extends MainCubitStates{}

final class MainGetCategoriesSuccessState extends MainCubitStates{}


final class MainCreateAddressLoadingState extends MainCubitStates{}

final class MainCreateAddressSuccessState extends MainCubitStates{
  Address address;
  MainCreateAddressSuccessState(this.address);
}

final class MainCreateAddressErrorState extends MainCubitStates{}

final class MainGetDeliveryItemsLoadingState extends MainCubitStates{}

final class MainGetDeliveryItemsSuccessState extends MainCubitStates{}

final class MainCreateDeliveryItemsLoadingState extends MainCubitStates{}

final class MainCreateDeliveryItemsSuccessState extends MainCubitStates{}

final class MainCreateDeliveryItemsErrorState extends MainCubitStates{}

final class MainCancelOrderLoadingState extends MainCubitStates{}

final class MainCancelOrderSuccessState extends MainCubitStates{}

final class MainCancelOrderErrorState extends MainCubitStates{}