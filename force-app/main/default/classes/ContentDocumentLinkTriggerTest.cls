@isTest
private class ContentDocumentLinkTriggerTest {
    public static Management__c managementObj;
    public static InputCheck__c inputchkObj;

    @isTest static void ContentDocumentTestforFiles(){ 
        // test start
		try{        
        	Contact contact = new Contact(LastName = 'トランス', FirstName = '') ;
            insert contact;
                            
            List<Management__c> managements = new List<Management__c>();
            Management__c managementObj = new Management__c(
            	ContractorName__c = contact.id,
                ContractorNameInput1__c = '契約者①',
                OutputFileList__c = 'ファイルネーム1,ファイルネーム2'
            );
            insert managementObj;
            
            ContentVersion contentVersion = new ContentVersion(
            	Title = 'Penguins',
            	PathOnClient = 'Penguins.pdf',
            	VersionData = Blob.valueOf('Test Content'),
            	IsMajorVersion = true
            );
            insert contentVersion;
            
            List<ContentDocument> documents = [
                SELECT Id, Title, LatestPublishedVersionId 
                FROM ContentDocument
            ];

            //create ContentDocumentLink  record 
            ContentDocumentLink cdl = New ContentDocumentLink();
            	cdl.LinkedEntityId = managementObj.id;
            	cdl.ContentDocumentId = documents[0].Id;
            insert cdl;
            delete cdl;
            
            //insert 
            Test.startTest();
            Test.stopTest();
            
        }
        catch(Exception e){
            system.debug('e.getMessage():'+e.getDmlFieldNames(0));
        }
    }
    
	@isTest static void ContentDocumentforFile(){
       
		try{
            
			Contact contact = new Contact(
            	MobilePhone = '03-1234-5678',
                LastName = 'トランス', FirstName = ''
            ) ;
            insert contact;
            
            List<InputCheck__c> inputChk = new List<InputCheck__c>();
            InputCheck__c inputChkobj = new InputCheck__c(
            	Name = '契約者名①',
                InputItemAPIName__c = 'ContractorNameInput1__c',
                Size__c=13) ;
            insert inputChkobj;
                        
            List<Management__c> managements = new List<Management__c>();
            Management__c managementObj = new Management__c(
                ContractorName__c = contact.id,
                ContractorNameInput1__c = '契約者①',
                OutputFileList__c = 'ファイルネーム1'
            );
            insert managementObj;
            
            ContentVersion contentVersion = new ContentVersion(
            	Title = 'Penguins',
            	PathOnClient = 'Penguins.pdf',
            	VersionData = Blob.valueOf('Test Content'),
            	IsMajorVersion = true
            );
            insert contentVersion;

            
            List<ContentDocument> documents = [
                SELECT Id, Title, LatestPublishedVersionId 
                FROM ContentDocument
            ];

            ContentDocumentLink cdl = New ContentDocumentLink();
            cdl.LinkedEntityId = managementObj.id;
            cdl.ContentDocumentId = documents[0].Id;
            insert cdl;
            delete cdl;
            
            Test.startTest();
            Test.stopTest();
            
        }
        catch(Exception e){
            system.debug('e.getMessage():'+e.getDmlFieldNames(0));
        }
    }
    
     @isTest static void ContentDocumentTestforBlank(){
       
        try{
            
            Contact contact = new Contact(LastName = 'トランス', FirstName = '') ;
            insert contact;
            
            List<InputCheck__c> inputChk = new List<InputCheck__c>();
            InputCheck__c inputChkobj = new InputCheck__c(
                						Name = '契約者名①' ,
                                        InputItemAPIName__c = 'ContractorNameInput1__c',
                                        Size__c=13) ;
            insert inputChkobj;
                        
            List<Management__c> managements = new List<Management__c>();
            Management__c managementObj = new Management__c(
                ContractorName__c = contact.id,
                ContractorNameInput1__c = '契約者①',
                OutputFileList__c = ''
            );
            insert managementObj;
            
            ContentVersion contentVersion = new ContentVersion(
                Title = 'Penguins',
                PathOnClient = 'Penguins.pdf',
                VersionData = Blob.valueOf('Test Content'),
                IsMajorVersion = true
            );
            insert contentVersion;

            
            List<ContentDocument> documents = [
                SELECT Id, Title, LatestPublishedVersionId 
                FROM ContentDocument
            ];

            ContentDocumentLink cdl = New ContentDocumentLink();
            cdl.LinkedEntityId = managementObj.id;
            cdl.ContentDocumentId = documents[0].Id;
            insert cdl;
            delete cdl;
            
            
            //insert 
            Test.startTest();
            Test.stopTest();
            
        }
        catch(Exception e){
            system.debug('e.getMessage():'+e.getDmlFieldNames(0));
        }
    }
    @isTest static void ContentDocumentTestreturn(){
       
        try{
            
            Contact contact = new Contact(LastName = 'トランス', FirstName = '') ;
            insert contact;
            
            List<InputCheck__c> inputChk = new List<InputCheck__c>();
            InputCheck__c inputChkobj = new InputCheck__c(
                						Name = '契約者名①' ,
                                        InputItemAPIName__c = 'ContractorNameInput1__c',
                                        Size__c=13) ;
            insert inputChkobj;
                        
            List<Management__c> managements = new List<Management__c>();
            Management__c managementObj = new Management__c(
                ContractorName__c = contact.id,
                ContractorNameInput1__c = '契約者①',
                OutputFileList__c = ''
            );
            insert managementObj;
            
            ContentVersion contentVersion = new ContentVersion(
                Title = 'Penguins',
                PathOnClient = 'Penguins.pdf',
                VersionData = Blob.valueOf('Test Content'),
                IsMajorVersion = true
            );
            insert contentVersion;

            
            List<ContentDocument> cd = [
                SELECT Id, Title, LatestPublishedVersionId 
                FROM ContentDocument
            ];

            ContentDocumentLink cdl = New ContentDocumentLink();
            cdl.LinkedEntityId = managementObj.id;
            cdl.ContentDocumentId = cd[0].Id;
            insert cdl;
            delete cdl;


            
            
            //insert 
            Test.startTest();
            Test.stopTest();
            
        }
        catch(Exception e){
            system.debug('e.getMessage():'+e.getDmlFieldNames(0));
        }
    }
}