@isTest
public class PushToVendorTest {
	@isTest static void testLessthanTwoHundred(){
        Account accy = new Account(Name='test');
        insert accy;
        List<Contact> conties = new List<Contact>();
        ID accId = [SELECT ID FROM Account Where Name =: 'test'].Id;
        Integer i = 0;
        do{
            i++;
            Contact conty = new Contact(LastName = 'Contact' + i, FirstName = 'Testing', AccountId = accId);
            conties.add(conty);
        }While(i < 200);
        insert conties;
        
        Account acctotest = [SELECT PushToVendor__c FROM Account Where Id =: accId];
        acctotest.PushToVendor__c = 'Yes';
        update acctotest;
        
        Contact contytotest = [SELECT Push_Date__c FROM Contact Where LastName =: 'Contact2'];
        System.assertNotEquals(null, contytotest.Push_Date__c);
    }
    
    @isTest static void testLessthanTenHundred(){
        Account accy = new Account(Name='test');
        insert accy;
        List<Contact> conties = new List<Contact>();
        ID accId = [SELECT ID FROM Account Where Name =: 'test'].Id;
        Integer i = 0;
        do{
            i++;
            Contact conty = new Contact(LastName = 'Contact' + i, FirstName = 'Testing', AccountId = accId);
            conties.add(conty);
        }While(i < 500);
        insert conties;
        
        Account acctotest = [SELECT PushToVendor__c FROM Account Where Id =: accId];
        acctotest.PushToVendor__c = 'Yes';
        update acctotest;
        
        Contact contytotest = [SELECT Push_Date__c FROM Contact Where LastName =: 'Contact2'];
        System.assertNotEquals(null, contytotest.Push_Date__c);
    }
    
    @isTest static void testMoreThanThousand(){
        Account accy = new Account(Name='test');
        insert accy;
        List<Contact> conties = new List<Contact>();
        ID accId = [SELECT ID FROM Account Where Name =: 'test'].Id;
        Integer i = 0;
        do{
            i++;
            Contact conty = new Contact(LastName = 'Contact' + i, FirstName = 'Testing', AccountId = accId);
            conties.add(conty);
        }While(i < 1002);
        insert conties;
        
        Account acctotest = [SELECT PushToVendor__c FROM Account Where Id =: accId];
        acctotest.PushToVendor__c = 'Yes';
        update acctotest;
        
        Contact contytotest = [SELECT Push_Date__c FROM Contact Where LastName =: 'Contact200'];
        System.assertNotEquals(null, contytotest.Push_Date__c);
    }
    
    @isTest static void testValueNo(){
        Account accy = new Account(Name='test', PushToVendor__c = 'Yes');
        insert accy;
        List<Contact> conties = new List<Contact>();
        ID accId = [SELECT ID FROM Account Where Name =: 'test'].Id;
        Integer i = 0;
        do{
            i++;
            Contact conty = new Contact(LastName = 'Contact' + i, FirstName = 'Testing', AccountId = accId, Push_Date__c = System.now());
            conties.add(conty);
        }While(i < 150);
        insert conties;
        
        Account acctotest = [SELECT PushToVendor__c FROM Account Where Id =: accId];
        acctotest.PushToVendor__c = 'No';
        update acctotest;
        
        Contact contytotest = [SELECT Push_Date__c FROM Contact Where LastName =: 'Contact2'];
        System.assertEquals(null, contytotest.Push_Date__c);
    }
}