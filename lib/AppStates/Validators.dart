import './StateFuncs.dart';
class Validators {
    static String? validateProductName(String? value) {
        if (value == null || value.isEmpty || value.contains(RegExp(r'[{}]'))) {
            return "請輸入正確的商品名稱";
        }
        if (MainAppState.hadName(value)) {
            return "商品名稱重複";
        }
        return null;
    }

    static String? validateSetName(String? value) {
        if (value == null || value.isEmpty || value.contains(RegExp(r'[{}]'))) {
            return "請輸入正確的套組名稱";
        }
        else if (MainAppState.hadSetName(value)) {
            return "套組名稱重複";
        }
        return null;
    }

    static String? validateProductNameAndSetName(String? value, String? lastName, bool _qIsDisabled) {
        if (value == null || value.isEmpty || value.contains(RegExp(r'[{}]'))) {
            return "請輸入正確的商品名稱";
        }
        else if (MainAppState.hadName(value)&&value!=lastName&&!_qIsDisabled) {
            return "商品名稱重複";
        }
        else if (MainAppState.hadSetName(value)&&value!=lastName&&_qIsDisabled) {
            return "套組名稱重複";
        }
        return null;
    }

    static String? validatePrice(String? value) {
        if (value == null || value.isEmpty || int.tryParse(value) == null || int.tryParse(value)!<0) {
            return "請輸入正確的價格";
        }
        return null;
    }

    static String? validateQuantity(String? value) {
        if (value == null || value.isEmpty || int.tryParse(value) == null || int.tryParse(value)!<0) {
            return "請輸入正確的數量";
        }
        return null;
    }

    static String? validateURL(String? value) {
        if ((value!.isNotEmpty && Uri.parse(value).isAbsolute == false)) {
            return "請輸入正確圖片URL";
        }
        return null;
    }
}