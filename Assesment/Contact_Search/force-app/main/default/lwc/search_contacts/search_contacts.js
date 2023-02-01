import { LightningElement, wire, track, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getContacts from "@salesforce/apex/keyAccountContactsController.getContacts";

const columns = [
    {label: 'View', type: 'button-icon', initialWidth: 75,
        typeAttributes: {
        iconName: 'action:preview',
        title: 'Preview',
        variant: 'border-filled',
        alternativeText: 'View'
        }},
    { label: 'Photo', fieldName: 'Photo__c'},    
    { label: 'Name', fieldName: 'Name' },
    { label: 'Email', fieldName: 'Email', type: 'email' },
    { label: 'Phone', fieldName: 'Phone' },
    { label: 'Role', fieldName: 'Role__c' },
    { label: 'ID', fielName: 'Id', type: 'Id'}
];
 
export default class LWCFilterSearchDatatable extends NavigationMixin(LightningElement) {
    imageURL;
    contactRecordId;
    @api recordId;
    @track contacts;
    @track data = [];
    @track columns = columns;
    @track contactRow={};
    @track rowOffset = 0;
    @track searchString;
    @track initialRecords;
    @track tableLoadingState = "true";
    @track modalContainer = false;
    
    
    //This refused to work, the $recordId was null when calling getContacts but had a value after that
    //I asked my mentor and he couldn't solve it either, so I had to recover all contacts
    
    @wire(getContacts, { AccountId: '$recordId' })
    wiredContacts({ error, data }) {
        if (data) {
            this.data = data;
            this.initialRecords = data;
            this.error = undefined;
            
        } else if (error) {
            this.error = error;
            this.data = undefined;
        }
        this.tableLoadingState = false;
    }

    handleSearch(event) {
        const searchKey = event.target.value.toLowerCase();
 
        if (searchKey) {
            this.data = this.initialRecords;
 
            if (this.data) {
                let searchRecords = [];
 
                for (let record of this.data) {
                    let valuesArray = Object.values(record);
 
                    for (let val of valuesArray) {
                        console.log('val is ' + val);
                        let strVal = String(val);
 
                        if (strVal) {
 
                            if (strVal.toLowerCase().includes(searchKey)) {
                                searchRecords.push(record);
                                break;
                            }
                        }
                    }
                }
 
                console.log('Matched Accounts are ' + JSON.stringify(searchRecords));
                this.data = searchRecords;
            }
        } else {
            this.data = this.initialRecords;
        }
    }

    handleRowAction(event){
        //this.contactRecordId = data.fields.Id.value;
        //this.imageURL = data.fields.Photo__c.value;
        const dataRow = event.detail.row;
        
        window.console.log('dataRow@@ ' + dataRow);
        
        this.contactRow=dataRow;
        
        window.console.log('contactRow## ' + dataRow);
        
        this.modalContainer=true;
    }

    closeModalAction(){

        this.modalContainer=false;
        
    }

    navigateToNewContact() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Contact',
                actionName: 'new'
            }
        });
    }

    navigateToRecordEditPage() {
        // Opens the record modal
        // to view a particular record.
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.contactRecordId,
                actionName: 'edit'
            }
        });
    }
    
}