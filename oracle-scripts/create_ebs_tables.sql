-- Inventory Items Master
CREATE TABLE MTL_SYSTEM_ITEMS_B (
    INVENTORY_ITEM_ID NUMBER PRIMARY KEY,
    SEGMENT1 VARCHAR2(50),
    DESCRIPTION VARCHAR2(240),
    PRIMARY_UOM_CODE VARCHAR2(10),
    ORGANIZATION_ID NUMBER
);

-- Onhand Quantities
CREATE TABLE MTL_ONHAND_QUANTITIES (
    INVENTORY_ITEM_ID NUMBER,
    ORGANIZATION_ID NUMBER,
    SUBINVENTORY_CODE VARCHAR2(10),
    QUANTITY_ON_HAND NUMBER,
    PRIMARY KEY (INVENTORY_ITEM_ID, ORGANIZATION_ID, SUBINVENTORY_CODE)
);

-- Sales Orders Header
CREATE TABLE OE_ORDER_HEADERS_ALL (
    HEADER_ID NUMBER PRIMARY KEY,
    ORDER_NUMBER VARCHAR2(30),
    ORDER_DATE DATE,
    CUSTOMER_ID NUMBER,
    ORDER_STATUS VARCHAR2(20)
);

-- Sales Orders Lines
CREATE TABLE OE_ORDER_LINES_ALL (
    LINE_ID NUMBER PRIMARY KEY,
    HEADER_ID NUMBER,
    INVENTORY_ITEM_ID NUMBER,
    ORDERED_QUANTITY NUMBER,
    UNIT_SELLING_PRICE NUMBER,
    LINE_STATUS VARCHAR2(20),
    FOREIGN KEY (HEADER_ID) REFERENCES OE_ORDER_HEADERS_ALL(HEADER_ID)
);

-- Purchase Orders Header
CREATE TABLE PO_HEADERS_ALL (
    PO_HEADER_ID NUMBER PRIMARY KEY,
    SEGMENT1 VARCHAR2(30),
    SUPPLIER_ID NUMBER,
    PO_DATE DATE,
    STATUS VARCHAR2(20)
);

-- Purchase Orders Lines
CREATE TABLE PO_LINES_ALL (
    PO_LINE_ID NUMBER PRIMARY KEY,
    PO_HEADER_ID NUMBER,
    INVENTORY_ITEM_ID NUMBER,
    QUANTITY NUMBER,
    UNIT_PRICE NUMBER,
    LINE_STATUS VARCHAR2(20),
    FOREIGN KEY (PO_HEADER_ID) REFERENCES PO_HEADERS_ALL(PO_HEADER_ID)
);
