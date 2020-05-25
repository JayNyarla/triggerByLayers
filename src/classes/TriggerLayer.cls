/*
*   Abstract class for a Layer. A Layer is a single independent computing unit of a trigger.
*/
public abstract class TriggerLayer 
{
    protected Map<Id, SObject> oldMap;

    protected Map<Id, SObject> newMap;

    protected List<SObject> oldList;

    protected List<SObject> newList;

    public TriggerLayer(){}

    public void init (Map<Id, SObject> oldMap, Map<Id, SObject> newMap, List<SObject> oldList, List<SObject> newList) {
        this.oldMap  = oldMap;
        this.newMap  = newMap;
        this.oldList = oldList;
        this.newList = newList;
    }

    /*
    *   Setup method selecting the records and performing the queries.
    */
    public abstract void setup();

    /*
    *   Execute method with the logic.
    */
    public abstract void execute();

    public void setupAndExecute() {
        setup();
        execute();
    }

}
