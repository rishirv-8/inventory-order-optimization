-- Reorder alert tracking table
CREATE TABLE REORDER_ALERTS (
    ALERT_ID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    INVENTORY_ITEM_ID NUMBER,
    ORGANIZATION_ID NUMBER,
    CURRENT_QTY NUMBER,
    REORDER_POINT NUMBER,
    CREATED_AT DATE DEFAULT SYSDATE
);

-- Procedure to check stock levels and generate reorder alerts
CREATE OR REPLACE PROCEDURE CHECK_REORDER_LEVELS AS
    CURSOR item_cur IS
        SELECT mi.INVENTORY_ITEM_ID,
               mi.ORGANIZATION_ID,
               ohq.QUANTITY_ON_HAND,
               CASE
                   WHEN mi.INVENTORY_ITEM_ID = 1001 THEN 50  -- Example reorder points
                   WHEN mi.INVENTORY_ITEM_ID = 1002 THEN 30
                   WHEN mi.INVENTORY_ITEM_ID = 1003 THEN 20
                   ELSE 10
               END AS REORDER_POINT
        FROM MTL_SYSTEM_ITEMS_B mi
        JOIN MTL_ONHAND_QUANTITIES ohq
            ON mi.INVENTORY_ITEM_ID = ohq.INVENTORY_ITEM_ID
           AND mi.ORGANIZATION_ID = ohq.ORGANIZATION_ID;

BEGIN
    FOR item_rec IN item_cur LOOP
        IF item_rec.QUANTITY_ON_HAND < item_rec.REORDER_POINT THEN
            INSERT INTO REORDER_ALERTS (
                INVENTORY_ITEM_ID,
                ORGANIZATION_ID,
                CURRENT_QTY,
                REORDER_POINT
            ) VALUES (
                item_rec.INVENTORY_ITEM_ID,
                item_rec.ORGANIZATION_ID,
                item_rec.QUANTITY_ON_HAND,
                item_rec.REORDER_POINT
            );
        END IF;
    END LOOP;
    
    COMMIT;
END;
/
