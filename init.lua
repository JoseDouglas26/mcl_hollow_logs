local S = minetest.get_translator("mcl_hollow_logs")

local function get_tiles(base_defs, strip_defs)
    return {
        "[combine:48x16:0,0="..base_defs.tiles[3]..
        ":16,0="..strip_defs.tiles[3]..
        ":32,0="..base_defs.tiles[1]
    }
end

local tpl_hollow = {
    collision_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.5, 0.5, 0.5, -0.375 },
			{ -0.5, -0.5, -0.5, -0.375, 0.5, 0.5 },
			{ 0.375, -0.5, -0.5, 0.5, 0.5, 0.5 },
			{ -0.5, -0.5, 0.375, 0.5, 0.5, 0.5 },
		}
	},
    drawtype = "mesh",
    mesh = "mcl_hollow_logs_log.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    on_place = mcl_util.rotate_axis,
    on_rotate = screwdriver.rotate_3way,
    sounds = mcl_sounds.node_sound_wood_defaults(),
    _mcl_blast_resistance = 2,
    _mcl_hardness = 2
}

for wood, defs in pairs(mcl_trees.woods) do
    local groups = {
        handy = 1, axey = 1, material_wood = 1,
        flammable = 3, fire_encouragement = 5, fire_flammability = 20
    }
    local material = "mcl_trees:tree_"..wood
    local strip_material = "mcl_trees:stripped_"..wood
    local base_defs = minetest.registered_nodes[material]
    local strip_defs = minetest.registered_nodes[strip_material]

    if defs.tree and defs.tree.groups then groups = defs.tree.groups end

    minetest.register_node(":mcl_trees:hollow_"..wood, table.merge(tpl_hollow, {
        description = S("@1 Hollow Log", defs.readable_name),
        groups = groups,
        tiles = get_tiles(base_defs, strip_defs),
        _mcl_burntime = base_defs._mcl_burntime,
        _mcl_cooking_output = base_defs._mcl_cooking_output,
        _on_axe_place = mcl_trees.strip_tree,
        _mcl_stripped_variant = "mcl_trees:stripped_hollow_"..wood,
    }))

    base_defs = strip_defs

    minetest.register_node(":mcl_trees:stripped_hollow_"..wood, table.merge(tpl_hollow, {
        description = S("Stripped @1 Hollow Log", defs.readable_name),
        groups = groups,
        tiles = get_tiles(base_defs, strip_defs),
        _mcl_burntime = base_defs._mcl_burntime,
        _mcl_cooking_output = base_defs._mcl_cooking_output
    }))

    minetest.register_craft({
        output = "mcl_trees:hollow_"..wood.." 4",
        recipe = {
            {"", material, ""},
            {material, "", material},
            {"", material, ""}
        }
    })

    minetest.register_craft({
        output = "mcl_trees:stripped_hollow_"..wood.." 4",
        recipe = {
            {"", strip_material, ""},
            {strip_material, "", strip_material},
            {"", strip_material, ""}
        }
    })
end
