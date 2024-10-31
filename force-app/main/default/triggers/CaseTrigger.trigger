trigger CaseTrigger on Case (after insert,after update) {
    CaseTriggerHandler handler = new CaseTriggerHandler();
    List<Case> bedoreCompletedVoiceList = new List<Case>();
	if(Trigger.isInsert && Trigger.isAfter){
        for ( Case newCase : Trigger.new ) {
            if(String.isNotEmpty(newCase.SessionID__c)){
                if(newCase.DialogueResult__c.equals(System.Label.DialogueCompleted)){
                    bedoreCompletedVoiceList.add(newCase);
                }          
            }
		}
	}
    if(Trigger.isUpdate && Trigger.isAfter){
        for ( Case newCase : Trigger.new ) {
            if(String.isNotEmpty(newCase.SessionID__c)){
                if(String.isNotEmpty(newCase.DialogueResult__c)){
                    if(newCase.DialogueResult__c.equals(System.Label.DialogueCompleted) && !newCase.IsLinked__c){
                        bedoreCompletedVoiceList.add(newCase);
                    }   
                }                
            }
		}
    }
    system.debug(bedoreCompletedVoiceList);
	handler.ConvertBedoreVoice(bedoreCompletedVoiceList);
}