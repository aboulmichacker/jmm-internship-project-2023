/*
@Company name : EI Technologies Lebanon
@Author : Jean Michel Moukarzel
@Date : 26-07-2023
@Description : Opportunity Trigger Handler Class
*/
public with sharing class OpportunityTriggerHandler {
/*
@Company name :EI Technologies Lebanon
@Author : Jean Michel Moukarzel
@Date : 26-07-2023
@Description : method that creates a service contract when opportunity is closed won
@Param List : list of opportunities used by trigger.new
@Return List : void
@Test Class: TestOpportunityTrigger
@Test Class Coverage: 100%
*/
    public static void CreateContract(List<Opportunity> triggernew) {
        
        Set<string> opportunityids = new Set<string>();
        Map<string,ServiceContract> opportunityContracts = new Map<string,ServiceContract>();
        
        //since price book id is required in the contract line and cannot be accessed directly from the opportunity line item, we need to use these sets and fill them in a map
        set<string> Pricebookids = new set<string>();
        set<string> productids = new set<string>();
        
        //create the service contract(s)
        for(Opportunity o: triggernew){
            
            if(o.StageName ==label.ClosedWon){
                ServiceContract c = new ServiceContract();
                c.Name = o.Name + ' Contract';
                c.accountId = o.accountId;
                c.StartDate = o.CloseDate;
                c.Pricebook2Id = o.Pricebook2Id;
                opportunityContracts.put(o.id,c);
                opportunityids.add(o.id);
                pricebookids.add(o.Pricebook2Id);
            }
        }
        
        insert opportunityContracts.values();
        
        //get the closed won oppportunity line items
        List<OpportunityLineItem> ClosedWonOpportunityProducts = [SELECT OpportunityId, UnitPrice,Product2Id, Quantity, Opportunity.CloseDate 
                                                                  FROM OpportunityLineItem 
                                                                  WHERE OpportunityId IN :opportunityids];

        List<ContractLineItem> ContractProducts = new list<ContractLineItem>();                                                            

        //get the product ids related to these line items
        for(OpportunityLineItem oli : ClosedWonOpportunityProducts)
        {
            productids.add(oli.Product2Id);
        }

        List<PricebookEntry> PricebookEntries = [SELECT id, Product2Id, Pricebook2id FROM PricebookEntry 
                                                WHERE Product2Id IN : productids 
                                                AND Pricebook2id IN :Pricebookids];
        Map<String,String> ProductPricebookentriesMap = new Map<string,string>();
        
        //fill the price book entry map that was mentioned in the beginning of the function
        for(PricebookEntry p: PricebookEntries)
        {
           ProductPricebookentriesMap.put(p.Product2Id,p.Id); 
        }
        //create the contract line items
        for(OpportunityLineItem oli: ClosedWonOpportunityProducts)
        {
            ContractLineItem cli = new ContractLineItem();
            
            cli.ServiceContractId = opportunityContracts.get(oli.OpportunityId).id;
            cli.UnitPrice = oli.UnitPrice;
            cli.StartDate = oli.Opportunity.CloseDate;
            cli.Quantity = oli.Quantity;
            cli.PricebookEntryId = ProductPricebookentriesMap.get(oli.Product2Id);
            ContractProducts.add(cli);
        }
        insert ContractProducts;
    }
}