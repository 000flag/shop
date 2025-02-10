package user.vo.customer;

import java.util.List;

public class OrderVO {
    private String id, tid, cus_no, prod_no, coupon_no, deli_no, order_code, count, order_date, amount, benefit_type, result_amount, pay_type, status, refund_bank, refund_account, reason_customer,
            reason_seller, retrieve_deli_no, prod_code, prod_name, prod_price, prod_sale, prod_image, prod_saled_price, brand, option_name, deli_name, pos_code, addr1,
            addr2, phone, deli_request, is_default, point_amount, inventory_no, coupon_name, sale_per, delivery_date, purchase_confirm_date, exchange_inventory_no,
            expected_point, refund_request_date, cancel_request_date, exchange_request_date, invoice_number, refund_completed_date, courier, seller_address, delivery_type, is_write_review, seller_no;

    public String getReason_seller() {
        return reason_seller;
    }

    public void setReason_seller(String reason_seller) {
        this.reason_seller = reason_seller;
    }

    public String getIs_write_review() {
        return is_write_review;
    }

    public void setIs_write_review(String is_write_review) {
        this.is_write_review = is_write_review;
    }

    public String getDelivery_type() {
        return delivery_type;
    }

    public void setDelivery_type(String delivery_type) {
        this.delivery_type = delivery_type;
    }

    public String getBenefit_type() {
        return benefit_type;
    }

    public void setBenefit_type(String benefit_type) {
        this.benefit_type = benefit_type;
    }

    public String getCourier() {
        return courier;
    }

    public void setCourier(String courier) {
        this.courier = courier;
    }

    public String getCancel_request_date() {
        return cancel_request_date;
    }

    public String getRefund_completed_date() {
        return refund_completed_date;
    }

    public void setRefund_completed_date(String refund_completed_date) {
        this.refund_completed_date = refund_completed_date;
    }

    public String getResult_amount() {
        return result_amount;
    }

    public void setResult_amount(String result_amount) {
        this.result_amount = result_amount;
    }

    public String getSeller_address() {
        return seller_address;
    }

    public void setSeller_address(String seller_address) {
        this.seller_address = seller_address;
    }

    public void setCancel_request_date(String cancel_request_date) {
        this.cancel_request_date = cancel_request_date;
    }

    public String getExchange_inventory_no() {
        return exchange_inventory_no;
    }

    public void setExchange_inventory_no(String exchange_inventory_no) {
        this.exchange_inventory_no = exchange_inventory_no;
    }

    public String getExchange_request_date() {
        return exchange_request_date;
    }

    public void setExchange_request_date(String exchange_request_date) {
        this.exchange_request_date = exchange_request_date;
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

    public String getReason_customer() {
        return reason_customer;
    }

    public void setReason_customer(String reason_customer) {
        this.reason_customer = reason_customer;
    }

    public String getRefund_request_date() {
        return refund_request_date;
    }

    public void setRefund_request_date(String refund_request_date) {
        this.refund_request_date = refund_request_date;
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

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getInventory_no() {
        return inventory_no;
    }

    public void setInventory_no(String inventory_no) {
        this.inventory_no = inventory_no;
    }

    public String getCoupon_name() {
        return coupon_name;
    }

    public void setCoupon_name(String coupon_name) {
        this.coupon_name = coupon_name;
    }

    public String getSale_per() {
        return sale_per;
    }

    public void setSale_per(String sale_per) {
        this.sale_per = sale_per;
    }

    private List<OrderVO> list;

    public String getRetrieve_deli_no() {
        return retrieve_deli_no;
    }

    public void setRetrieve_deli_no(String retrieve_deli_no) {
        this.retrieve_deli_no = retrieve_deli_no;
    }

    public String getPoint_amount() {
        return point_amount;
    }

    public String getIs_default() {
        return is_default;
    }

    public void setIs_default(String is_default) {
        this.is_default = is_default;
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

    public void setPoint_amount(String point_amount) {
        this.point_amount = point_amount;
    }

    public String getDeli_name() {
        return deli_name;
    }

    public void setDeli_name(String deli_name) {
        this.deli_name = deli_name;
    }

    public String getPos_code() {
        return pos_code;
    }

    public void setPos_code(String pos_code) {
        this.pos_code = pos_code;
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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getDeli_request() {
        return deli_request;
    }

    public void setDeli_request(String deli_request) {
        this.deli_request = deli_request;
    }

    public String getOption_name() {
        return option_name;
    }

    public void setOption_name(String option_name) {
        this.option_name = option_name;
    }

    public String getProd_code() {
        return prod_code;
    }

    public void setProd_code(String prod_code) {
        this.prod_code = prod_code;
    }

    public String getProd_name() {
        return prod_name;
    }

    public void setProd_name(String prod_name) {
        this.prod_name = prod_name;
    }

    public String getProd_price() {
        return prod_price;
    }

    public void setProd_price(String prod_price) {
        this.prod_price = prod_price;
    }

    public String getProd_sale() {
        return prod_sale;
    }

    public void setProd_sale(String prod_sale) {
        this.prod_sale = prod_sale;
    }

    public String getProd_image() {
        return prod_image;
    }

    public void setProd_image(String prod_image) {
        this.prod_image = prod_image;
    }

    public String getProd_saled_price() {
        return prod_saled_price;
    }

    public void setProd_saled_price(String prod_saled_price) {
        this.prod_saled_price = prod_saled_price;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public List<OrderVO> getList() {
        return list;
    }

    public void setList(List<OrderVO> list) {
        this.list = list;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getSeller_no() {
        return seller_no;
    }

    public void setSeller_no(String seller_no) {
        this.seller_no = seller_no;
    }
}
