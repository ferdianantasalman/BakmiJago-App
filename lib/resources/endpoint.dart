// ignore_for_file: constant_identifier_names

class Endpoint {
  // Auth
  static const user_auth = 'api/auth/login';
  static const user_register = 'api/auth/register';
  static const user_logout = 'api/auth/logout';
  static const user_refresh_token = 'api/auth/refresh';
  static const user_info = 'api/auth/me';
  // Product
  static const user_product = 'api/auth/products';
  // Order
  static const user_orders = 'api/auth/orders';
  static const user_orders_id = 'api/auth/orders/';
  static const user_orders_invoice = 'api/auth/orders_invoice/';
  // Invoice
  static const user_invoice_time = 'api/auth/invoices/';
  static const user_invoices = 'api/auth/invoices';
  // Report
  static const user_reports = 'api/auth/reports';
  static const user_reports_time = 'api/auth/reports_time/';
  static const user_income = 'api/auth/reports_income/';
  static const user_outcome = 'api/auth/reports_outcome/';
  static const user_revenue = 'api/auth/reports_revenue/';
}
