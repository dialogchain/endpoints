# -*- coding: utf-8 -*-
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# NO CHECKED-IN PROTOBUF GENCODE
# source: example.proto
# Protobuf Python Version: 5.29.0
"""Generated protocol buffer code."""
from google.protobuf import descriptor as _descriptor
from google.protobuf import descriptor_pool as _descriptor_pool
from google.protobuf import runtime_version as _runtime_version
from google.protobuf import symbol_database as _symbol_database
from google.protobuf.internal import builder as _builder
_runtime_version.ValidateProtobufRuntimeVersion(
    _runtime_version.Domain.PUBLIC,
    5,
    29,
    0,
    '',
    'example.proto'
)
# @@protoc_insertion_point(imports)

_sym_db = _symbol_database.Default()




DESCRIPTOR = _descriptor_pool.Default().AddSerializedFile(b'\n\rexample.proto\x12\x07\x65xample\"\x1c\n\x0cHelloRequest\x12\x0c\n\x04name\x18\x01 \x01(\t\"-\n\nHelloReply\x12\x0f\n\x07message\x18\x01 \x01(\t\x12\x0e\n\x06status\x18\x02 \x01(\x05\",\n\x0b\x44\x61taRequest\x12\r\n\x05\x63ount\x18\x01 \x01(\x05\x12\x0e\n\x06prefix\x18\x02 \x01(\t\"<\n\x0c\x44\x61taResponse\x12\n\n\x02id\x18\x01 \x01(\x05\x12\r\n\x05value\x18\x02 \x01(\t\x12\x11\n\ttimestamp\x18\x03 \x01(\t\"E\n\rClientMessage\x12\x11\n\tclient_id\x18\x01 \x01(\t\x12\x0f\n\x07message\x18\x02 \x01(\t\x12\x10\n\x08sequence\x18\x03 \x01(\x05\"c\n\x0eServerResponse\x12\x11\n\tserver_id\x18\x01 \x01(\t\x12\x10\n\x08response\x18\x02 \x01(\t\x12\x19\n\x11received_sequence\x18\x03 \x01(\x05\x12\x11\n\ttimestamp\x18\x04 \x01(\t2\x95\x02\n\x07Greeter\x12\x38\n\x08SayHello\x12\x15.example.HelloRequest\x1a\x13.example.HelloReply\"\x00\x12=\n\nStreamData\x12\x14.example.DataRequest\x1a\x15.example.DataResponse\"\x00\x30\x01\x12\x43\n\x0c\x43lientStream\x12\x16.example.ClientMessage\x1a\x17.example.ServerResponse\"\x00(\x01\x12L\n\x13\x42idirectionalStream\x12\x16.example.ClientMessage\x1a\x17.example.ServerResponse\"\x00(\x01\x30\x01\x62\x06proto3')

_globals = globals()
_builder.BuildMessageAndEnumDescriptors(DESCRIPTOR, _globals)
_builder.BuildTopDescriptorsAndMessages(DESCRIPTOR, 'example_pb2', _globals)
if not _descriptor._USE_C_DESCRIPTORS:
  DESCRIPTOR._loaded_options = None
  _globals['_HELLOREQUEST']._serialized_start=26
  _globals['_HELLOREQUEST']._serialized_end=54
  _globals['_HELLOREPLY']._serialized_start=56
  _globals['_HELLOREPLY']._serialized_end=101
  _globals['_DATAREQUEST']._serialized_start=103
  _globals['_DATAREQUEST']._serialized_end=147
  _globals['_DATARESPONSE']._serialized_start=149
  _globals['_DATARESPONSE']._serialized_end=209
  _globals['_CLIENTMESSAGE']._serialized_start=211
  _globals['_CLIENTMESSAGE']._serialized_end=280
  _globals['_SERVERRESPONSE']._serialized_start=282
  _globals['_SERVERRESPONSE']._serialized_end=381
  _globals['_GREETER']._serialized_start=384
  _globals['_GREETER']._serialized_end=661
# @@protoc_insertion_point(module_scope)
