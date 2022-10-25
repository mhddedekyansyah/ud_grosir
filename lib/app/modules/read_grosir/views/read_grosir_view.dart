import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ud_grosir/app/data/models/grosir_model.dart';
import 'package:ud_grosir/app/routes/app_pages.dart';

import '../controllers/read_grosir_controller.dart';

class ReadGrosirView extends GetView<ReadGrosirController> {
  const ReadGrosirView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<List<GrosirModel>>(
      stream: controller.fetchGrosir(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return snapshot.data!.isNotEmpty
            ? SafeArea(
                child: Container(
                    margin: const EdgeInsets.all(24),
                    child: ListView(
                        children: snapshot.data
                            ?.map(
                              (e) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(15),
                                  leading:
                                      e.imgUrl != null && e.imgUrl!.isNotEmpty
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                '${e.imgUrl}',
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.asset(
                                                'assets/images/bonbon.png',
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                  tileColor: Colors.white,
                                  title: Text("${e.name}"),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            Get.toNamed(Routes.EDIT_GROSIR,
                                                arguments: {'grosir': e});
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.blue,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            controller.deleteGrosir(e.id).then(
                                                (value) => controller
                                                    .deleteUser(e.id));
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList() as List<Widget>)))
            : Center(child: Text('grosir kosong'));
      },
    ));
  }
}
