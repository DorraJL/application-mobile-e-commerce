import 'package:animate_do/animate_do.dart';
import 'package:e_commers/Bloc/Delivery/delivery_bloc.dart';
import 'package:e_commers/Bloc/category/category_bloc.dart';
import 'package:e_commers/Bloc/product/product_bloc.dart';
import 'package:e_commers/Bloc/user/user_bloc.dart';
import 'package:e_commers/Models/Response/GetAllDeliveryResponse.dart';
import 'package:e_commers/Models/Response/response_categories_home.dart';
import 'package:e_commers/Service/LivraisonController.dart';
import 'package:e_commers/service/ProductController.dart';
import 'package:e_commers/Service/urls.dart';
import 'package:e_commers/ui/themes/colors_tech4iot.dart';
import 'package:e_commers/ui/widgets/shimmer_frave.dart';
import 'package:e_commers/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:e_commers/Models/Response/response_categories.dart';
import '../../../Service/urls.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:e_commers/Bloc/Orders/orders_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

part 'animation_route.dart';
part 'modal_success.dart';
part 'modal_loading.dart';
part 'error_message.dart';
part 'modal_warning.dart';
part 'loading_upload.dart';
part 'modal_add_cart.dart';
part 'access_permission.dart';
part 'modal_picture.dart';
part 'modal_loading_short.dart';
part 'modal_categories.dart';
part 'modal_delete_product.dart';
part 'categories.dart';
part 'custom_markert.dart';
part 'url_lancher_frave.dart';
part 'modal_succes.dart';
part 'FraveIndicator.dart';
part 'navigator_route_fade_in.dart';
part 'modal_delete_category.dart';
part 'modal_delete_subcategory.dart';
part 'modal_info.dart';
part 'ModalSelectDelivery.dart';
part 'modal_delete_user.dart';