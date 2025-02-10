package comm.vo.seller;

public class OrderVO {
    private String id, cus_no, prod_no, coupon_no, deli_no, retrieve_deli_no, inventory_no, exchange_inventory_no, tid, order_code, count, amount, benefit_type, result_amount, expected_point, pay_type, status, order_date, invoice_number, delivery_date, purchase_confirm_date, refund_bank, refund_account, refund_request_date, cancel_request_date, exchange_request_date, reason_customer, reason_seller, refund_completed_date;
    private String cus_id, cus_name;
    private String prod_name;
    private String addr1,addr2,deli_name,phone;
    private String option_name, option_count;
    ProductVO product;
    DeliveryVO delivery;

    public String getExchange_inventory_no() {
        return exchange_inventory_no;
    }

    public void setExchange_inventory_no(String exchange_inventory_no) {
        this.exchange_inventory_no = exchange_inventory_no;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getBenefit_type() {
        return benefit_type;
    }

    public void setBenefit_type(String benefit_type) {
        this.benefit_type = benefit_type;
    }

    public String getResult_amount() {
        return result_amount;
    }

    public void setResult_amount(String result_amount) {
        this.result_amount = result_amount;
    }

    public String getExpected_point() {
        return expected_point;
    }

    public void setExpected_point(String expected_point) {
        this.expected_point = expected_point;
    }

    public String getInvoice_number() {
        return invoice_number;
    }

    public void setInvoice_number(String invoice_number) {
        this.invoice_number = invoice_number;
    }

    public String getDelivery_date() {
        return delivery_date;
    }

    public void setDelivery_date(String delivery_date) {
        this.delivery_date = delivery_date;
    }

    public String getPurchase_confirm_date() {
        return purchase_confirm_date;
    }

    public void setPurchase_confirm_date(String purchase_confirm_date) {
        this.purchase_confirm_date = purchase_confirm_date;
    }

    public String getRefund_request_date() {
        return refund_request_date;
    }

    public void setRefund_request_date(String refund_request_date) {
        this.refund_request_date = refund_request_date;
    }

    public String getCancel_request_date() {
        return cancel_request_date;
    }

    public void setCancel_request_date(String cancel_request_date) {
        this.cancel_request_date = cancel_request_date;
    }

    public String getExchange_request_date() {
        return exchange_request_date;
    }

    public void setExchange_request_date(String exchange_request_date) {
        this.exchange_request_date = exchange_request_date;
    }

    public String getReason_customer() {
        return reason_customer;
    }

    public void setReason_customer(String reason_customer) {
        this.reason_customer = reason_customer;
    }

    public String getReason_seller() {
        return reason_seller;
    }

    public void setReason_seller(String reason_seller) {
        this.reason_seller = reason_seller;
    }

    public String getRefund_completed_date() {
        return refund_completed_date;
    }

    public void setRefund_completed_date(String refund_completed_date) {
        this.refund_completed_date = refund_completed_date;
    }

    public String getAddr1() {
        return addr1;
    }

    public void setAddr1(String addr1) {
        this.addr1 = addr1;
    }

    public String getAddr2() {
        return addr2;
    }

    public void setAddr2(String addr2) {
        this.addr2 = addr2;
    }

    public String getDeli_name() {
        return deli_name;
    }

    public void setDeli_name(String deli_name) {
        this.deli_name = deli_name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getProd_name() {
        return prod_name;
    }

    public void setProd_name(String prod_name) {
        this.prod_name = prod_name;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTid() {
        return tid;
    }

    public void setTid(String tid) {
        this.tid = tid;
    }

    public String getCus_no() {
        return cus_no;
    }

    public void setCus_no(String cus_no) {
        this.cus_no = cus_no;
    }

    public String getProd_no() {
        return prod_no;
    }

    public void setProd_no(String prod_no) {
        this.prod_no = prod_no;
    }

    public String getCoupon_no() {
        return coupon_no;
    }

    public void setCoupon_no(String coupon_no) {
        this.coupon_no = coupon_no;
    }


    public String getDeli_no() {
        return deli_no;
    }

    public void setDeli_no(String deli_no) {
        this.deli_no = deli_no;
    }

    public String getOrder_code() {
        return order_code;
    }

    public void setOrder_code(String order_code) {
        this.order_code = order_code;
    }

    public String getCount() {
        return count;
    }

    public void setCount(String count) {
        this.count = count;
    }

    public String getOrder_date() {
        return order_date;
    }

    public void setOrder_date(String order_date) {
        this.order_date = order_date;
    }

    public String getPay_type() {
        return pay_type;
    }

    public void setPay_type(String pay_type) {
        this.pay_type = pay_type;
    }

    public String getRefund_bank() {
        return refund_bank;
    }

    public void setRefund_bank(String refund_bank) {
        this.refund_bank = refund_bank;
    }

    public String getRefund_account() {
        return refund_account;
    }

    public void setRefund_account(String refund_account) {
        this.refund_account = refund_account;
    }


    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getInventory_no() {
        return inventory_no;
    }

    public void setInventory_no(String inventory_no) {
        this.inventory_no = inventory_no;
    }

    public String getRetrieve_deli_no() {
        return retrieve_deli_no;
    }

    public void setRetrieve_deli_no(String retrieve_deli_no) {
        this.retrieve_deli_no = retrieve_deli_no;
    }

    public String getCus_id() {
        return cus_id;
    }

    public void setCus_id(String cus_id) {
        this.cus_id = cus_id;
    }

    public String getCus_name() {
        return cus_name;
    }

    public void setCus_name(String cus_name) {
        this.cus_name = cus_name;
    }

    public String getOption_name() {
        return option_name;
    }

    public void setOption_name(String option_name) {
        this.option_name = option_name;
    }

    public String getOption_count() {
        return option_count;
    }

    public void setOption_count(String option_count) {
        this.option_count = option_count;
    }

    public ProductVO getProduct() {
        return product;
    }

    public void setProduct(ProductVO product) {
        this.product = product;
    }

    public DeliveryVO getDelivery() {
        return delivery;
    }

    public void setDelivery(DeliveryVO delivery) {
        this.delivery = delivery;
    }
}