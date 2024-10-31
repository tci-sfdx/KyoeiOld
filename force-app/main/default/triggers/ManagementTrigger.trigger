trigger ManagementTrigger on Management__c (before update, 
                                            before insert,after insert,after update) {
    ManagementTriggerController handler = new ManagementTriggerController(Trigger.isExecuting, Trigger.size);
	CaseTriggerHandler caseHandler = new CaseTriggerHandler();
    List<Management__c> bedoreExclusionList = new List<Management__c>();
	List<string> bedoreLinkedSessionIdList = new List<string>(); 
    if(Trigger.isInsert && Trigger.isBefore){
        for ( Management__c newManagement : Trigger.new ) {
            if(string.isBlank(newManagement.BedoreSessionID__c)){
                bedoreExclusionList.add(newManagement);
            }
		}
        handler.OnBeforeInsert(bedoreExclusionList);
    }else if(Trigger.isUpdate && Trigger.isBefore){
        handler.OnBeforeUpdate(Trigger.old, Trigger.new);
    }
	if((Trigger.isInsert || Trigger.isUpdate) && Trigger.isAfter){
        for ( Management__c newManagement : Trigger.new ) {
            if(string.isNotBlank(newManagement.BedoreSessionID__c)){
                system.debug('BedoreSessionID__c:'+newManagement.BedoreSessionID__c);
                bedoreLinkedSessionIdList.add(newManagement.BedoreSessionID__c);
            }
		}
    system.debug('bedoreLinkedSessionIdList:'+bedoreLinkedSessionIdList);                                            
	caseHandler.updateBedoreLinkedCase(bedoreLinkedSessionIdList); 
	}
}