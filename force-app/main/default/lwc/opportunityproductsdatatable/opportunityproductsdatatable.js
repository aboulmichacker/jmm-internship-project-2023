//child component that contains the products datatable
import { LightningElement,api } from 'lwc';

export default class Opportunityproductsdatatable extends LightningElement {
    //get the products from the parent
    @api products;
    
    //assign the datatable columns
    productcolumns = [
        {label: 'Vehicle Name', fieldName:'Productname' },
        {label: 'Price per Day', fieldName: 'Price' },
        {label: 'Original Price', fieldName: 'OriginalPrice' },
        {label: 'Brand', fieldName: 'Type' },
        {label: 'Color', fieldName: 'Color' },
        {label: 'Year of Production', fieldName: 'Year' },
        {label: 'Quantity', fieldName: 'Quantity' }
    ];
}