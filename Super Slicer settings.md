# Super Slicer settings

# Filament settings custom variables
### Notes -> Custom variables
Variable for filament pressure advance to use at slicer custom G-code macro
```
pressure_advance=0.55
```

## Printer custom G-code

### Start G-code
Full start G-code can be like this:
```
PRINT_START EXTRUDER_TEMP=[first_layer_temperature] BED_TEMP=[first_layer_bed_temperature] Z_OFFSET=0 RETRACT={retract_length[0]} ACCEL=2250 ACCEL_TO_DECEL=1125 SQUARE_CORNER_VELOCITY=3 AREA_START={first_layer_print_min[0]},{first_layer_print_min[1]} AREA_END={first_layer_print_max[0]},{first_layer_print_max[1]}
```

Used start G-code:
```
PRINT_START EXTRUDER_TEMP=[first_layer_temperature] BED_TEMP=[first_layer_bed_temperature] RETRACT={retract_length[0]} AREA_START={first_layer_print_min[0]},{first_layer_print_min[1]} AREA_END={first_layer_print_max[0]},{first_layer_print_max[1]}
```

### End G-code
```
PRINT_END
```

### Tool change G-code
```
PAUSE_TO_FILAMENT_CHANGE
```

### Between extrusion role change G-code
Placeholder variables 
- extrusion_role
- last_extrusion_role
- layer_num
- layer_z

Variables `extrusion_role` and `last_extrusion_role` can take string values 
- last_extrusion_role
- Perimeter
- ExternalPerimeter
- OverhangPerimeter
- InternalInfill
- SolidInfill
- TopSolidInfill
- BridgeInfill
- GapFill
- Skirt
- SupportMaterial
- SupportMaterialInterface
- WipeTower
- Mixed


This G-code macro for 
- not stress the extruder and filament too much during infill and other moves
- set pressure advance for extrusion roles. Calculated from filament variable `pressure_advance`
```
{if layer_num == 1}
    {if extrusion_role == "WipeTower" or
        extrusion_role == "SupportMaterial" or
        extrusion_role == "SupportMaterialInterface"
    }
        SET_PRESSURE_ADVANCE ADVANCE=0
    {elsif extrusion_role == "Perimeter" or
           extrusion_role == "ExternalPerimeter"
    }
        SET_PRESSURE_ADVANCE ADVANCE={pressure_advance * 0.8}
    {else}
        SET_PRESSURE_ADVANCE ADVANCE={pressure_advance * 0.5}
    {endif}
{else}
    SET_PRESSURE_ADVANCE ADVANCE={pressure_advance} SMOOTH_TIME=0.04

    {if extrusion_role == "SolidInfill" or 
        extrusion_role == "GapFill" or 
        extrusion_role == "WipeTower" or
        extrusion_role == "SupportMaterial" or
        extrusion_role == "SupportMaterialInterface"
    }
        SET_PRESSURE_ADVANCE ADVANCE=0
    {elsif extrusion_role == "Perimeter"}
        SET_PRESSURE_ADVANCE ADVANCE={pressure_advance * 0.8} SMOOTH_TIME=0.04
    {elsif extrusion_role == "InternalInfill"}
        SET_PRESSURE_ADVANCE ADVANCE={pressure_advance * 0.7} SMOOTH_TIME=0.05
    {endif}
{endif}
```

### Color change G-code
```
PAUSE
```

### Pause print G-code
```
PAUSE
```
