declare @CollectionID as nvarchar(8) = 'SMSDM003' -- All Desktop and Server clients collection

select 
r.Name0 Computername,
CASE 
                  WHEN enc.chassistypes0 LIKE '1' THEN 'Virtual' 
                  WHEN enc.chassistypes0 LIKE '2' THEN 'Blade Server' 
                  WHEN enc.chassistypes0 LIKE '3' THEN 'Desktop' 
                  WHEN enc.chassistypes0 LIKE '4' THEN 'Low-Profile Desktop' 
                  WHEN enc.chassistypes0 LIKE '5' THEN 'Pizza-Box' 
                  WHEN enc.chassistypes0 LIKE '6' THEN 'Mini Tower' 
                  WHEN enc.chassistypes0 LIKE '7' THEN 'Tower' 
                  WHEN enc.chassistypes0 LIKE '8' THEN 'Portable' 
                  WHEN enc.chassistypes0 LIKE '9' THEN 'Laptop' 
                  WHEN enc.chassistypes0 LIKE '10' THEN 'Notebook' 
                  WHEN enc.chassistypes0 LIKE '11' THEN 'Hand-Held' 
                  WHEN enc.chassistypes0 LIKE '12' THEN 'Mobile Device in Docking Station' 
                  WHEN enc.chassistypes0 LIKE '13' THEN 'All-in-One' 
                  WHEN enc.chassistypes0 LIKE '14' THEN 'Sub-Notebook' 
                  WHEN enc.chassistypes0 LIKE '15' THEN 'Space Saving Chassis' 
                  WHEN enc.chassistypes0 LIKE '16' THEN 'Ultra Small Form Factor' 
                  WHEN enc.chassistypes0 LIKE '17' THEN 'Server Tower Chassis' 
                  WHEN enc.chassistypes0 LIKE '18' THEN 'Mobile Device in Docking Station' 
                  WHEN enc.chassistypes0 LIKE '19' THEN 'Sub-Chassis' 
                  WHEN enc.chassistypes0 LIKE '20' THEN 'Bus-Expansion chassis' 
                  WHEN enc.chassistypes0 LIKE '21' THEN 'Peripheral Chassis' 
                  WHEN enc.chassistypes0 LIKE '22' THEN 'Storage Chassis' 
                  WHEN enc.chassistypes0 LIKE '23' THEN 'Rack-Mounted Chassis' 
                  WHEN enc.chassistypes0 LIKE '24' THEN 'Sealed-Case PC' 
                  ELSE 'Unknown' 
                END 
                AS [Chassis Type]
from fn_rbac_R_System (@UserSIDs) r
left join v_gs_system_enclosure enc on enc.ResourceID = r.ResourceID
where r.ResourceID in (select fcm.resourceid from fn_rbac_FullCollectionMembership(@UserSIDs) fcm where fcm.CollectionID = @CollectionID)
