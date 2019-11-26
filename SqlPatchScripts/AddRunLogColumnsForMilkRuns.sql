ALTER TABLE `SERV`.`RunLog` 
ADD COLUMN `CollectionPostcode` VARCHAR(8) NULL AFTER `CollectionLocationID`,
ADD COLUMN `RunLogType` VARCHAR(2) NULL AFTER `RunLogID`;
