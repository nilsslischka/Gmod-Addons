local flowTable = {
	"gmod_mcore_test 1",
	"mat_queue_mode -1",
	"cl_threaded_bone_setup 1",
	"cl_threaded_client_leaf_system 1",
	"r_threaded_particles 1",
	"r_threaded_renderables 1",
	"r_queued_ropes 1",
	"studio_queue_mode 1",
	"r_decals 2048",
	"mp_decals 2048",
	"mat_wateroverlaysize 4",
	"r_ForceWaterLeaf 0",
	"r_maxmodeldecal 4",
	--"cl_playerspraydisable 1",
	"cl_ejectbrass 0",
	"muzzleflash_light 0",
	"r_drawmodeldecals 0",
	"ai_expression_optimization 1",
	"cl_autohelp 0"
}

local function execute_cmds()
	print("Now making the following changes to improve general game performance:")
	for k, v in pairs(flowTable) do
		LocalPlayer():ConCommand(v)
		print(v)
	end
	print("Changes complete")
end

hook.Add("HUDPaint", "crazy_multicore_stuff", function()
	hook.Remove("HUDPaint", "crazy_multicore_stuff")
	
	execute_cmds()
end)

concommand.Add("crazy_multicore_stuff", execute_cmds)