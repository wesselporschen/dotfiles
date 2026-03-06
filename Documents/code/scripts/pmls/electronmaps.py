from pymol import cmd
from pymol import util
from psico.xtal import supercell

# This script generates many symmetry mates to fill in the electron density electronmaps
# alternatively show only parts around specified residue
# usage "electronmaps 4EIY, 201"

def electronmaps(pdb, res=None):
    cmd.reinitialize()

    cmd.fetch(pdb, type="pdb1", async_=0)
    cmd.fetch(pdb, type="2fofc", name="2fofc", async_=0)
    cmd.fetch(pdb, type="fofc", name="fofc", async_=0)

    cmd.hide("all")
    cmd.show("cartoon")

    supercell(a=1, b=1, c=1, withmates=1, prefix="symmates")

    if res:
        cmd.select("target_res", f"{pdb} and resi {res}")
        cmd.hide("all")

        symmates = cmd.get_object_list("symmates000")

        for symmate in symmates:
            util.cnc(symmate)

            sel = f"near_res_{symmate}"
            cmd.select(
                sel,
                f"byres ({symmate} within 10 of resi {res})"
            )
            cmd.show("sticks", sel)
            cmd.label(f"({sel} and name CA)", '"%s%s" % (resn, resi)')
            cmd.label(f"({sel} and q < 1.0)", '"%.2f" % q')

            cmd.show("spheres", f"solvent and ({sel})")
            cmd.set("sphere_scale", 0.3, f"solvent and ({sel})")
            cmd.set("sphere_transparency", 0.6, f"solvent and ({sel})")



    if res:
        cmd.isomesh("mesh2fofc_1.5s", "2fofc", 1.5,  carve=10, selection=f"(resi {res})")
        cmd.isomesh("mesh+fofc_3s", "fofc", 3.0, carve=10, selection=f"(resi {res})")
        cmd.isomesh("mesh-fofc_3s", "fofc", -3.0,  carve=10, selection=f"(resi {res})")
    else:
        cmd.isomesh("mesh2fofc_1.5s", "2fofc", 1.5, carve=8.0)
        cmd.isomesh("mesh+fofc_3s", "fofc", 3.0, carve=8.0)
        cmd.isomesh("mesh-fofc_3s", "fofc", -3.0,  carve=8.0)



    cmd.set("mesh_width", 0.5)

    cmd.color("grey70", "mesh2fofc_1.5s")
    cmd.color("green", "mesh+fofc_3s")
    cmd.color("red", "mesh-fofc_3s")

    cmd.show("mesh", "mesh*")

cmd.extend("electronmaps", electronmaps)

