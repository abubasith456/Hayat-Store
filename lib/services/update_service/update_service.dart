import 'package:flutter/material.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/util/custom_dialog.dart';
import 'package:shop_app/util/intent.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

import '../firestore_and_remoteConfig/firestore_database.dart';

var message;
String? updateLink;
late String updateOptionalLink;
String? maintenanceMessage;
void listernUpdateAvailable(BuildContext context) {
  if (getRemoteConfig() != null) {
    getRemoteConfig()!.addListener(() async {
      //Config boolean values
      bool isUodateAvailable =
          getRemoteConfig()!.getBool(remoteConfigUpdateKey);
      bool isAppInMaintenance =
          getRemoteConfig()!.getBool(remoteConfigAppInMaintenanceKey);
      bool isAppWillInMaintenance =
          getRemoteConfig()!.getBool(remoteConfigAppWillInMaintenance);
      print("update available? ==>  " + isUodateAvailable.toString());
      print("isAppInMaintenance available? ==>  " +
          isAppInMaintenance.toString());
      print("isAppWillInMaintenance available? ==>  " +
          isAppWillInMaintenance.toString());
      if (isUodateAvailable) {
        // ---------------------------- App update available -------------------------
        var docSnapshot =
            await getCollectionData(collectionName: updateCollectionName)!
                .doc(updateDocumentInfoName)
                .get();
        if (docSnapshot.exists) {
          message = getFirestoreSnapshotData(docSnapshot: docSnapshot)?[
              updateFieldMessageKey]; // <-- retrive update message
          updateLink = getFirestoreSnapshotData(docSnapshot: docSnapshot)?[
              updateLinkKey]; // <-- retrive update url
          updateOptionalLink = getFirestoreSnapshotData(
              docSnapshot: docSnapshot)?[updateOptionalLinkKey];
        } else {
          return;
        }
        CustomDialog.showConfirmDialog(
            context: context,
            title: updateDialogTitle,
            message: message != null ? message : "",
            negativeCallback: () {
              Navigator.of(context).pop();
            },
            possitiveCallback: () {
              //Need to add aplication callback url
              Navigator.of(context).pop();
              launchURL(url: updateLink, optionalUrl: updateOptionalLink);
            },
            negativeText: cancelUpdateButtonText,
            positiveText: updateButtonText,
            dialogType: PanaraDialogType.warning);
      } else if (isAppInMaintenance) {
        // ---------------------------- App in Maintenance ----------------------------
        var maintenanceInfo =
            await getCollectionData(collectionName: miantenanceCollectionKey)!
                .doc(miantenanceDocumentKey)
                .get();
        if (maintenanceInfo.exists) {
          maintenanceMessage = getFirestoreSnapshotData(
              docSnapshot: maintenanceInfo)![appInMaintenanceMessageKey];
        }
        CustomDialog customDialog = CustomDialog(context: context);
        customDialog.showProgressDialog(
            maintenanceMessage!.replaceAll("\\n", "\n"), appInMaintenanceTitle,
            alertType: StylishDialogType.ERROR);
      } else if (isAppWillInMaintenance) {
        // ---------------------------- App will be in Maintenance --------------------------
        var maintenanceInfo =
            await getCollectionData(collectionName: miantenanceCollectionKey)!
                .doc(miantenanceDocumentKey)
                .get();
        if (maintenanceInfo.exists) {
          maintenanceMessage = getFirestoreSnapshotData(
              docSnapshot: maintenanceInfo)![appWillInMaintenanceMessageKey];
        }
        CustomDialog.showAlertDialog(
            context: context,
            title: appWillInMaintenanceTitle,
            message: maintenanceMessage!.replaceAll("\\n", "\n"),
            possitiveCallback: () {
              Navigator.of(context).pop();
            },
            positiveText: okButtonString,
            dialogType: PanaraDialogType.warning);
      }
    });
  }
}
