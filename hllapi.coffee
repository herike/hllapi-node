ffi = require('ffi')
ref = require('ref')
hlldll = ffi.DynamicLibrary("./hllapi32.dll")
hllapi = hlldll.get('WinHLLAPI')
#hllapi = hlldll.WinHLLAPI
#WinHLLAPI = ffi.ForeignFunction(hllapi, Number,  [Number,  String,  Number, Number])

functionNum = ref.refType('int')
dataString = ref.types.CString
length = ref.refType(ref.types.int32)
pos = ref.refType(ref.types.int32)
posReturn = ref.refType(ref.types.int32)

hllapiLib = ffi.Library('hllapi32', {
    'WinHLLAPI': [posReturn, [functionNum, ref.types.CString, length, pos]]
});

connectPresentationSpace = (presentationSpace, callback) ->

    function_number = ref.alloc(ref.types.int32, 1)
    data_string = presentationSpace
    length = ref.alloc(ref.types.int32,4)
    ps_position = ref.alloc(ref.types.int32, 0)
    ps_position_return = ref.alloc(ref.types.int32)
    console.log function_number.deref() + " ... " + data_string + " ... " + length.deref()
    console.log functionNum.indirection + " test "
    console.log function_number.indirection
    ps_position_return = hllapiLib.WinHLLAPI(function_number, data_string, length, ps_position)
    console.log ps_position_return.deref()
    return

disconnectPresentationSpace = () ->
    function_number = ref.alloc(ref.types.int32, 2)
    data_string = 'test'
    length = ref.alloc(ref.types.int32,4)
    ps_position = ref.alloc(ref.types.int32, 0)
    ps_position_return = ref.alloc(ref.types.int32)
    console.log function_number.deref() + " ... " + data_string + " ... " + length.deref()
    ps_position_return = hllapiLib.WinHLLAPI.async(function_number, data_string, length, ps_position)
    return ps_position_return.deref()

sendKey = (key) ->
    function_number = ref.alloc(ref.types.int32, 3)
    data_string = key
    length = ref.alloc(ref.types.int32,key.length)
    ps_position = ref.alloc(ref.types.int32, 0)
    ps_position_return = ref.alloc(ref.types.int32)
    console.log function_number.deref() + " ... " + data_string + " ... " + length.deref()
    ps_position_return = hllapiLib.WinHLLAPI(function_number, data_string, length, ps_position)
    return ps_position_return.deref()


connectPresentationSpace('A')
console.log sendKey('H')
console.log sendKey('I')
