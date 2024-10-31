trigger MailAddressCheckTrigger on EmailMessage (before insert) {
    static final String VALID_DOMAINS = System.Label.MailValidToAddress.toLowerCase(); 
    static final String MAILADDRESS_DELIMITER = ';| |,|\n';
    static final String INPUT_ERROR_MESSAGE = System.Label.MailInvalidToAddressMessage;
    
    if (Trigger.new.isEmpty() || Trigger.new.size() != 1) {
        return;
    }
    
    for(EmailMessage eMsg : Trigger.new) {
        if (eMsg.parentId != null) {
            continue;
        }
        
        if (eMsg.Incoming == true) {
            continue;
        }
        
        List<String> mailList = eMsg.ToAddress.split(MAILADDRESS_DELIMITER);
        if (eMsg.CcAddress != null) {
            List<String> ccMailList = eMsg.CcAddress.split(MAILADDRESS_DELIMITER);
            mailList.addAll(ccMailList);
        }
        
        if (mailList == null || mailList.isEmpty()) {
            continue;
        }
        for (String mail : mailList) {
            Integer atmarkIndex= mail.indexOf('@');
            if (atmarkIndex != -1) {
                String domainString = mail.substring(atmarkIndex, mail.length()).toLowerCase();    
                if (!VALID_DOMAINS.contains(domainString) ) {
                    Trigger.new[0].addError(INPUT_ERROR_MESSAGE);
                    break;
                }
            }
        }
    }
}