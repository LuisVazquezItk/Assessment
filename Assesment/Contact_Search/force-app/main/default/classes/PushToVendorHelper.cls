public class PushToVendorHelper {
    public static void updateContacts(List<Account> acc){
        List<Contact> cons = [SELECT Push_Date__c, AccountId FROM Contact];
        
        for(Account accsFrom: acc){
            system.debug(accsFrom.PushToVendor__c);
            List<Contact> toUp = new List<Contact>();
            for(Contact consToUp: cons){
                if(consToUp.AccountId == accsFrom.Id){
                    if(accsFrom.PushToVendor__c == 'Yes'){
                        consToUp.Push_Date__c = System.now();
                        System.debug(consToUp.Push_Date__c);
                    }else{
                        consToUp.Push_Date__c = null;
                        System.debug(consToUp.Push_Date__c);
                    }
                    toUp.add(consToUp);
                }
        	}
            
            integer contactsAmount = toUp.size();
            
            if(contactsAmount <= 200){
                update toUp;
            }else if(contactsAmount <= 1000){
                updateSynchro(toUp);
            }else{
                updateByBatches(toUp);
            }
        }
        
    }

    private static void updateSynchro(List<Contact> lesserThanThousand){
        update lesserThanThousand;
    }
    
    private static void updateByBatches(List<Contact> toCut){
        List<Contact> batches = new List<Contact>();
        integer i = 0, j = 0;
        for(Contact cutedCons: toCut){
            i++;
            batches.add(cutedCons);
            if(i == 150){
                update batches;
                i = 0;
                batches.clear();
            }
        }
        if(i < 150){
            update batches;
        }
    }
}