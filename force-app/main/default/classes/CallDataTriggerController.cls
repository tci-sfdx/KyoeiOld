public class CallDataTriggerController {
    
        public CallDataTriggerController(boolean isExecuting, integer size){
            
        }
    	//ChangeData
        public void ChangeData(Contact newContact){
            Datetime myDate = Datetime.now();
            String strConvertedDate = myDate.format('yyyy/MM/dd/HH:mm', 'Asia/Tokyo');
            system.debug(strConvertedDate);
        	PostingDate au = new PostingDate();
			
        	newContact.IncomingCallDay__c = au.Posting(strConvertedDate);
            newContact.IncomingCallTime__c = au.PostingTime(strConvertedDate);
        }
    
    //OnBeforeInsert
    public void OnBeforeInsert(Contact[] newContacts){
        for(Contact newContact : newContacts){
            system.debug(newContact.IncomingCallDayAuto__c);
            system.debug(newContact.IncomingCallDay__c);
            if(string.isBlank(newContact.BedoreSessionID__c)){
                ChangeData(newContact);
            }else{
                if(String.isBlank(newContact.LastName)){
                    newContact.LastName = 'フメイ';
                }
            }
        }
    }

}