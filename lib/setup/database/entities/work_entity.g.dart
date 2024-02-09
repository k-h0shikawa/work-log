// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkEntityImpl _$$WorkEntityImplFromJson(Map<String, dynamic> json) =>
    _$WorkEntityImpl(
      id: json['id'] as int? ?? null,
      workDateTime: DateTime.parse(json['workDateTime'] as String),
      workName: json['workName'] as String,
      workDetail: json['workDetail'] as String,
      workMemo: json['workMemo'] as String,
      productId: json['productId'] as int,
      createdOn: json['createdOn'] as String? ?? null,
      createdBy: json['createdBy'] as String? ?? null,
      updatedOn: json['updatedOn'] as String? ?? null,
      updatedBy: json['updatedBy'] as String? ?? null,
    );

Map<String, dynamic> _$$WorkEntityImplToJson(_$WorkEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'workDateTime': instance.workDateTime.toIso8601String(),
      'workName': instance.workName,
      'workDetail': instance.workDetail,
      'workMemo': instance.workMemo,
      'productId': instance.productId,
      'createdOn': instance.createdOn,
      'createdBy': instance.createdBy,
      'updatedOn': instance.updatedOn,
      'updatedBy': instance.updatedBy,
    };
