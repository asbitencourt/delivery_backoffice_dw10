// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:delivery_backoffice_dw10/src/models/payment_type_model.dart';
import 'package:mobx/mobx.dart';

import 'package:delivery_backoffice_dw10/src/repositories/payment_type/payment_type_repository.dart';

part 'payment_type_controller.g.dart';

enum PaymentStateStatus {
  initial,
  loading,
  loaded,
  error,
  addOrUpdatePayment,
  saved,
}

class PaymentTypeController = PaymentTypeControllerBase
    with _$PaymentTypeController;

abstract class PaymentTypeControllerBase with Store {
  final PaymentTypeRepository _paymentTypeRepository;
  @readonly
  var _status = PaymentStateStatus.initial;
  @readonly
  var _paymentTypes = <PaymentTypeModel>[];
  @readonly
  String? _errorMessage;
  @readonly
  PaymentTypeModel? _paymentTypeSelected;
  @readonly
  bool? _filterEnabled;

  PaymentTypeControllerBase(
    this._paymentTypeRepository,
  );
  @action
  void filterChanged(bool? enabled) => _filterEnabled = enabled;

  @action
  Future<void> loadingPayments() async {
    try {
      _status = PaymentStateStatus.loading;
      _paymentTypes = await _paymentTypeRepository.findAll(_filterEnabled);
      _status = PaymentStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao buscar as formas de pagamento', error: e, stackTrace: s);
      _status = PaymentStateStatus.error;
      _errorMessage = 'Erro ao buscar as formas de pagamento';
    }
  }

  @action
  Future<void> addPayment() async {
    _status = PaymentStateStatus.loading;
    await Future.delayed(Duration.zero);
    _paymentTypeSelected = null;
    _status = PaymentStateStatus.addOrUpdatePayment;
  }

  @action
  Future<void> editPayment(PaymentTypeModel payment) async {
    _status = PaymentStateStatus.loading;
    await Future.delayed(Duration.zero);
    _paymentTypeSelected = payment;
    _status = PaymentStateStatus.addOrUpdatePayment;
  }

  @action
  Future<void> savePayment(
      {int? id,
      required String name,
      required String acronym,
      required bool enabled}) async {
    try {
      _status = PaymentStateStatus.loading;
      final paymentTypeModel = PaymentTypeModel(
          id: id, name: name, acronym: acronym, enabled: enabled);
      await _paymentTypeRepository.save(paymentTypeModel);
      _status = PaymentStateStatus.saved;
    } catch (e, s) {
      log('${e}', error: e, stackTrace: s);
      _status = PaymentStateStatus.error;
      _errorMessage = '${e}';
    }
  }
}
