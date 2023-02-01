public with sharing class keyAccountContactsController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String accountIdret) {
        system.debug([SELECT Name, Email, Phone, Role__c, Photo__c, Id FROM Contact]);
        return [SELECT Name, Email, Phone, Role__c, Photo__c, Id FROM Contact];
    }
}