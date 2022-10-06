class API {
  static const baseUrl = 'https://bwabank.my.id/api';

  static const register = '$baseUrl/register';
  static const login = '$baseUrl/login';
  static const checkEmail = '$baseUrl/is-email-exist';
  static const logout = '$baseUrl/logout';

  static const updatePin = '$baseUrl/wallets';

  static const topup = '$baseUrl/top_ups';
  static const transfer = '$baseUrl/transfers';
  static const getTransaction = '$baseUrl/transactions';
  static const dataPlan = '$baseUrl/data-plans';

  static const getUser = '$baseUrl/users';
  static const updateProfile = '$baseUrl/users';
  static const getUserByUsername = '$baseUrl/users';

  static const getPaymentMethod = '$baseUrl/payment_methods';

  static const transferHistories = '$baseUrl/transfer_histories';

  static const getTips = '$baseUrl/tips';

  static const getOperatorCards = '$baseUrl/operator_cards';
}