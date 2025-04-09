-- Package Specification
CREATE OR REPLACE PACKAGE inv_item_pkg AS
    PROCEDURE insert_item (
        p_item_id        IN NUMBER,
        p_segment1       IN VARCHAR2,
        p_description    IN VARCHAR2,
        p_uom_code       IN VARCHAR2,
        p_org_id         IN NUMBER
    );

    PROCEDURE update_item (
        p_item_id        IN NUMBER,
        p_description    IN VARCHAR2,
        p_uom_code       IN VARCHAR2
    );

    FUNCTION get_item (
        p_item_id        IN NUMBER
    ) RETURN VARCHAR2;

    PROCEDURE list_items;
END inv_item_pkg;
/

-- Package Body
CREATE OR REPLACE PACKAGE BODY inv_item_pkg AS

    PROCEDURE insert_item (
        p_item_id        IN NUMBER,
        p_segment1       IN VARCHAR2,
        p_description    IN VARCHAR2,
        p_uom_code       IN VARCHAR2,
        p_org_id         IN NUMBER
    ) IS
    BEGIN
        INSERT INTO MTL_SYSTEM_ITEMS_B (
            INVENTORY_ITEM_ID,
            SEGMENT1,
            DESCRIPTION,
            PRIMARY_UOM_CODE,
            ORGANIZATION_ID
        ) VALUES (
            p_item_id,
            p_segment1,
            p_description,
            p_uom_code,
            p_org_id
        );
        COMMIT;
    END;

    PROCEDURE update_item (
        p_item_id        IN NUMBER,
        p_description    IN VARCHAR2,
        p_uom_code       IN VARCHAR2
    ) IS
    BEGIN
        UPDATE MTL_SYSTEM_ITEMS_B
        SET DESCRIPTION = p_description,
            PRIMARY_UOM_CODE = p_uom_code
        WHERE INVENTORY_ITEM_ID = p_item_id;

        COMMIT;
    END;

    FUNCTION get_item (
        p_item_id        IN NUMBER
    ) RETURN VARCHAR2 IS
        v_result VARCHAR2(4000);
    BEGIN
        SELECT 'Item: ' || SEGMENT1 || ' | Desc: ' || DESCRIPTION || ' | UOM: ' || PRIMARY_UOM_CODE
        INTO v_result
        FROM MTL_SYSTEM_ITEMS_B
        WHERE INVENTORY_ITEM_ID = p_item_id;

        RETURN v_result;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 'Item not found.';
    END;

    PROCEDURE list_items IS
    BEGIN
        FOR rec IN (
            SELECT * FROM MTL_SYSTEM_ITEMS_B
        ) LOOP
            DBMS_OUTPUT.PUT_LINE(
                'Item ID: ' || rec.INVENTORY_ITEM_ID || ', ' ||
                'Name: ' || rec.SEGMENT1 || ', ' ||
                'Desc: ' || rec.DESCRIPTION || ', ' ||
                'UOM: ' || rec.PRIMARY_UOM_CODE
            );
        END LOOP;
    END;

END inv_item_pkg;
/
