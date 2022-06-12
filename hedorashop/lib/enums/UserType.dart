enum UserType { Admin, DataEntry, StoreManager, Customer, Merchant, Unkown }

class UserTypeHelper {
  static String getValue(UserType userType) {
    switch (userType) {
      case UserType.StoreManager:
        return "StoreManager";
      case UserType.Admin:
        return "Admin";
      case UserType.DataEntry:
        return "DataEntry";
      case UserType.Customer:
        return "Customer";
      case UserType.Merchant:
        return "Merchant";
      case UserType.Unkown:
        return "Unkown";
      default:
        return 'Unkown';
    }
  }

  static UserType getEnum(String userType) {
    if (userType == getValue(UserType.StoreManager)) {
      return UserType.StoreManager;
    } else if (userType == getValue(UserType.Admin)) {
      return UserType.Admin;
    } else if (userType == getValue(UserType.DataEntry)) {
      return UserType.DataEntry;
    } else if (userType == getValue(UserType.Merchant)) {
      return UserType.Merchant;
    } else if (userType == getValue(UserType.Customer)) {
      return UserType.Customer;
    } else {
      return UserType.Unkown;
    }
  }
}
