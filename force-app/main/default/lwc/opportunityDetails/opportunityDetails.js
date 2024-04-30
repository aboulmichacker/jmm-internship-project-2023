//parent component that contains opportunity details

import { LightningElement,api,wire} from 'lwc';
import getOppDetails from '@salesforce/apex/OpportunitiesController.getOppDetails';
export default class OpportunityDetails extends LightningElement {
    //use the api decorator on record id in order to retrive the record id related to the record page
    @api recordId; 
    opportunitydetails;
    products;
    //use the wire decorator in order for the apex method to be called when the record page is loading
    @wire(getOppDetails, { opportunityid: '$recordId' })
    wiredAccount({ error, data }) {  
        if (data) {

            this.opportunitydetails = data;
            this.products = data.Products; //store the products in a variable since its a wrapper
        } else if (error) {
            console.log('error: '+ error);
        }
    }
}