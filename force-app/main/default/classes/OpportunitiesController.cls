/*
@Company name : EI Technologies Lebanon
@Author : Jean Michel Moukarzel
@Date : 26-07-2023
@Description : Opportunities Controller Class
@Test Class: OpportunitiesControllerTest
@Test Class Coverage: 100%
*/
public with sharing class OpportunitiesController {

    //opportunity details wrapper
    public class WRP_Opportunity
    {
        @AuraEnabled public String CloseDate {get; set;}
        @AuraEnabled public String oppDate {get; set;}
        @AuraEnabled public String SalesAgent {get; set;}
        @AuraEnabled public String Stage {get; set;}
        @AuraEnabled public list<WRP_Product> Products {get; set;}

    }
    //product details wrapper
    public class WRP_Product
    {
        @AuraEnabled public String Id {get; set;}
        @AuraEnabled public String Productname {get; set;}
        @AuraEnabled public String Type {get; set;}
        @AuraEnabled public String Color {get; set;}
        @AuraEnabled public Decimal Year {get; set;}
        @AuraEnabled public Decimal Price {get; set;}
        @AuraEnabled public Decimal OriginalPrice {get; set;}
        @AuraEnabled public Decimal Quantity {get; set;}
    }

/*
@Company name :EI Technologies Lebanon
@Author : Jean Michel Moukarzel
@Date : 26-07-2023
@Description : method that gets all opportunity details
@Param List : opportunity id
@Return List : opportunity details wrapper
*/
    @AuraEnabled(cacheable=true)
    public static WRP_Opportunity getOppDetails(string opportunityid)
    {   
        WRP_Opportunity oppdetails = new WRP_Opportunity();
        list<WRP_Product> productdetailslist = new list<WRP_Product>();

        //fill values related to opportunity
        for(Opportunity opportunity: [SELECT Id, Closedate, CreatedDate, Owner.Name, StageName FROM Opportunity WHERE Id = :opportunityid LIMIT 1])
        {
            oppdetails.CloseDate = opportunity.CloseDate != null ? string.valueof(opportunity.CloseDate) : '';
            oppdetails.oppDate = opportunity.CreatedDate != null ? string.valueof(opportunity.CreatedDate) : '';
            oppdetails.SalesAgent = Opportunity.Owner.Name != null ? Opportunity.Owner.Name : '';
            oppdetails.Stage = Opportunity.StageName != null ? Opportunity.StageName : '';
        }
        
        for(OpportunityLineItem oli: [SELECT Id, Product2.Name, ListPrice, Quantity, PricebookEntry.UnitPrice, Product2.Color__c, 
                                                Product2.Year__c, Product2.Type__c 
                                                FROM OpportunityLineItem 
                                                WHERE OpportunityId = :opportunityid])
        {
            //fill values related to the products 
            
            WRP_Product productdetails = new WRP_Product();

            productdetails.Id = oli.Id != null ? oli.Id : '';
            productdetails.OriginalPrice = oli.PricebookEntry.UnitPrice != null ? oli.PricebookEntry.UnitPrice : 0;
            productdetails.Price = oli.ListPrice != null ? oli.ListPrice : 0;
            productdetails.Year = oli.Product2.Year__c != null ? oli.Product2.Year__c : 0;
            productdetails.Productname = oli.Product2.Name != null ? oli.Product2.Name : '';
            productdetails.Color = oli.Product2.Color__c != null ? oli.Product2.Color__c : '';
            productdetails.Type = oli.Product2.Type__c != null ? oli.Product2.Type__c : '';
            productdetails.Quantity = oli.Quantity != null ? oli.Quantity : 0;
            
            productdetailslist.add(productdetails);
        }
        
        oppdetails.Products = productdetailslist;

        return oppdetails;
    }
}