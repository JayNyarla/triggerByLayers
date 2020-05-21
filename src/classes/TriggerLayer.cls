/*
*   Abstract class for a Layer. A Layer is a single independent computing unit of a trigger.
*/
public abstract class TriggerLayer 
{
    protected Map<Id, SObject> oldMap;

    protected Map<Id, SObject> newMap;

    public TriggerLayer(){}

    public TriggerLayer(Map<Id, SObject> oldMap, Map<Id, SObject> newMap) {
        this.oldMap = oldMap;
        this.newMap = newMap;
    }

    public void setOldMap(Map<Id, SObject> oldMap) {
        this.oldMap = oldMap;
    }

    public void setNewMap(Map<Id, SObject> newMap) {
        this.newMap = newMap;
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
