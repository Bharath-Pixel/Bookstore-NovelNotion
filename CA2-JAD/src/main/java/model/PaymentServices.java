package model;

import java.util.*;
import com.paypal.api.payments.*;
import com.paypal.base.rest.*;
 
public class PaymentServices {
    private static final String CLIENT_ID = "ARPMSkw3iVTcV-RzOdPy2C-KMRyI9SmJoyGlF7qQYZNOt-oqlK_8AWl88dUejK14QXAQ4hxEC2RGx9lo";
    private static final String CLIENT_SECRET = "EMDmGtU4qZr74qMqzsm8KpXi0-0KMXHMIiDUKx1F-BripPSMiUOsnw7O6G_Zqn5jS3z0SzLNFhs3G_W7";
    private static final String MODE = "sandbox";
 
    public String authorizePayment(OrderDetail orderDetail)        
            throws PayPalRESTException {       
 
        Payer payer = getPayerInformation();
        RedirectUrls redirectUrls = getRedirectURLs();
        List<Transaction> listTransaction = getTransactionInformation(orderDetail);
         
        Payment requestPayment = new Payment();
        requestPayment.setTransactions(listTransaction);
        requestPayment.setRedirectUrls(redirectUrls);
        requestPayment.setPayer(payer);
        requestPayment.setIntent("authorize");
 
        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
 
        Payment approvedPayment = requestPayment.create(apiContext);
 
        return getApprovalLink(approvedPayment);
 
    }
     
    private Payer getPayerInformation() {
        Payer payer = new Payer();
        payer.setPaymentMethod("paypal");
         
        PayerInfo payerInfo = new PayerInfo();
        payerInfo.setFirstName("William")
                 .setLastName("Peterson")
                 .setEmail("william.peterson@company.com");
         
        payer.setPayerInfo(payerInfo);
         
        return payer;
    }
     
    private RedirectUrls getRedirectURLs() {
        RedirectUrls redirectUrls = new RedirectUrls();
        redirectUrls.setCancelUrl("http://localhost:8080/PaypalTest/cancel.html");
        redirectUrls.setReturnUrl("http://localhost:8080/CA2-JAD/ReviewPayment");
         
        return redirectUrls;
    }
     
    private List<Transaction> getTransactionInformation(OrderDetail orderDetail) {
        Details details = new Details();
        details.setShipping(orderDetail.getShipping());
        details.setSubtotal(orderDetail.getSubtotal());
        details.setTax(orderDetail.getTax());
     
        Amount amount = new Amount();
        amount.setCurrency("USD");
        amount.setTotal(orderDetail.getTotal());
        amount.setDetails(details);
     
        Transaction transaction = new Transaction();
        transaction.setAmount(amount);
        transaction.setDescription(orderDetail.getProductName());
         
        ItemList itemList = new ItemList();
        List<Item> items = new ArrayList<>();
         
        Item item = new Item();
        item.setCurrency("USD");
        item.setName(orderDetail.getProductName());
        item.setPrice(orderDetail.getSubtotal());
        item.setTax(orderDetail.getTax());
        item.setQuantity("1");
         
        items.add(item);
        itemList.setItems(items);
        transaction.setItemList(itemList);
     
        List<Transaction> listTransaction = new ArrayList<>();
        listTransaction.add(transaction);  
         
        return listTransaction;
    }
     
    private String getApprovalLink(Payment approvedPayment) {
        List<Links> links = approvedPayment.getLinks();
        String approvalLink = null;
         
        for (Links link : links) {
            if (link.getRel().equalsIgnoreCase("approval_url")) {
                approvalLink = link.getHref();
                break;
            }
        }
         
        return approvalLink;
    }
    
    public Payment getPaymentDetails(String paymentId) throws PayPalRESTException {
        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
        return Payment.get(apiContext, paymentId);
    }
    
    public Payment executePayment(String paymentId, String payerId)
            throws PayPalRESTException {
        PaymentExecution paymentExecution = new PaymentExecution();
        paymentExecution.setPayerId(payerId);
     
        Payment payment = new Payment().setId(paymentId);
     
        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
        return payment.execute(apiContext, paymentExecution);
    }
}