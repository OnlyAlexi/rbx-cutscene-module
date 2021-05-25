local H_CUTSCENE = {}

RS_S = game:GetService("RunService").RenderStepped
DIALOGUE_UI = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Frame.Dialogue
pcall(function()local starterGui=game:GetService('StarterGui');starterGui:SetCore("TopbarEnabled",false)end)


H_CUTSCENE.Me = 1
H_CUTSCENE.L_CAMERA_MOVEMENTS = {}
H_CUTSCENE.RAW_C_PAN = 0
H_CUTSCENE.L_CAMERA = workspace.CurrentCamera;H_CUTSCENE.L_CAMERA.CameraType=Enum.CameraType.Scriptable


H_CUTSCENE.L_PANCAMERA_QUEUE = function(o,x,t,easingStyle)
	local OR_C_SUBJECT=H_CUTSCENE.L_CAMERA.CameraSubject
	local C_OFFSET_L=x.CFrame:VectorToWorldSpace(Vector3.FromNormalId("Front"))
	local OR_CFRAME_C = o.CFrame;local T_CFRAME_C = CFrame.new(x.Position+6*C_OFFSET_L, x.Position)
	H_CUTSCENE.L_CAMERA.CFrame = OR_CFRAME_C 
	local C_TWEEN_OBJ = game:GetService('TweenService'):Create(H_CUTSCENE.L_CAMERA,TweenInfo.new(t),{CFrame = T_CFRAME_C})
	table.insert(H_CUTSCENE.L_CAMERA_MOVEMENTS,C_TWEEN_OBJ)
end

H_CUTSCENE.L_ZOOM_QUEUE = function(amount, t, boolr, p)
	local T_PASSED = {amount, t, boolr, p}
	table.insert(H_CUTSCENE.L_CAMERA_MOVEMENTS, T_PASSED)
end

H_CUTSCENE.L_CUTCAMERA_QUEUE = function(x,pb,t,d, dialog)
	local ORG_CFRAME=H_CUTSCENE.L_CAMERA.CFrame;local TRG_CFRAME=x.CFrame
	local C_CUT_OBJ = {x,pb,t,d, dialog}
	table.insert(H_CUTSCENE.L_CAMERA_MOVEMENTS,C_CUT_OBJ)
end

H_CUTSCENE.L_PLAYCUT_E = function(cut)
	local OR_C_SUBJECT=H_CUTSCENE.L_CAMERA.CameraSubject;local TA_CFRAME=cut[1]
	local C_OFFSET_L=cut[1].CFrame:VectorToWorldSpace(Vector3.FromNormalId("Front"))
	local OR_OFFSET_L
		if(OR_C_SUBJECT.ClassName=="Humanoid") then
				OR_OFFSET_L=OR_C_SUBJECT.Parent.Head.CFrame:VectorToWorldSpace(Vector3.FromNormalId("Front"))
		else OR_OFFSET_L=OR_C_SUBJECT.CFrame:VectorToWorldSpace(Vector3.FromNormalId("Front")) end
			if(cut[2] == true) then
					H_CUTSCENE.L_CAMERA.CameraType=Enum.CameraType.Scriptable
					H_CUTSCENE.L_CAMERA.CoordinateFrame=CFrame.new(TA_CFRAME.Position+cut[4]*C_OFFSET_L,TA_CFRAME.Position)
					wait(cut[3])
					H_CUTSCENE.L_CAMERA.CoordinateFrame=CFrame.new(OR_C_SUBJECT.Parent.Head.Position+cut[4]*OR_OFFSET_L,OR_C_SUBJECT.Parent.Head.Position)
		else if(cut[2] == false) then 
				H_CUTSCENE.L_CAMERA.CameraSubject=TA_CFRAME
				H_CUTSCENE.L_CAMERA.CoordinateFrame=CFrame.new(TA_CFRAME.Position+cut[4]*C_OFFSET_L,TA_CFRAME.Position)
					if(cut[5] == false) then
							wait(cut[3])
					else if (cut[5] == true)then
							wait(0)
						end
					end
				end
			end
		end


 H_CUTSCENE.TE_SPELL_DIAGLOGUE = function(char,t,ti)
	local STR_SPELL_OBJ = {char,t,ti}
	table.insert(H_CUTSCENE.L_CAMERA_MOVEMENTS,STR_SPELL_OBJ)
end

H_CUTSCENE.EF_FADE_OUT = function(t)
	for i = 0,1,t do
		DIALOGUE_UI.Parent.Fade.Transparency=DIALOGUE_UI.Parent.Fade.BackgroundTransparency-i
		RS_S:wait() 
	end
end

H_CUTSCENE.FN_CUTSCENE_D = function()
	H_CUTSCENE.L_CAMERA.CameraSubject=game:GetService("Players").LocalPlayer.Character.Humanoid;H_CUTSCENE.L_CAMERA.CameraType=Enum.CameraType.Custom
	DIALOGUE_UI.Parent.BlackBar.Visible=false;DIALOGUE_UI.Parent.TextLabel.Visible=false;DIALOGUE_UI.Visible=false
end

H_CUTSCENE.PERFORM_ZOOM = function(tablee)
	local DEFAULT_FOV = H_CUTSCENE.L_CAMERA.FieldOfView
	for i = 0,tablee[1],1 do
		H_CUTSCENE.L_CAMERA.FieldOfView = H_CUTSCENE.L_CAMERA.FieldOfView - 1.5
		RS_S:wait()
	end
	wait(tablee[4])
	if(tablee[3] == true) then
		for i = 0,tablee[1],1 do
			H_CUTSCENE.L_CAMERA.FieldOfView = H_CUTSCENE.L_CAMERA.FieldOfView + 1
			RS_S:wait()
		end
	end
	wait(tablee[2])
	--H_CUTSCENE.L_CAMERA.FieldOfView = DEFAULT_FOV
end


H_CUTSCENE.L_CAMERA_PLAYALLQUEUE = function()
	DIALOGUE_UI.Parent.BlackBar.Visible=true;DIALOGUE_UI.Parent.TextLabel.Visible=true
	for i,v in pairs (H_CUTSCENE.L_CAMERA_MOVEMENTS) do
	if(type(v) == "userdata") then 
	v:Play();v.Completed:Wait()
		else if (type(v) == "table") then
				if(type(v[1]) == "userdata") then
				H_CUTSCENE.L_PLAYCUT_E(v)
				else if(type(v[1]) == "string") then
						local CLONE_OF_TEXT = game.ReplicatedStorage.Dialog:Clone()
						CLONE_OF_TEXT.Parent = workspace
						CLONE_OF_TEXT.Position = v[2].Position + Vector3.new(0,3,0)
						CLONE_OF_TEXT.Orientation = v[2].Orientation
						local T_C = v[1]:split("")
						for q = 1,#T_C,1 do
							CLONE_OF_TEXT.SurfaceGui.TextLabel.Text = CLONE_OF_TEXT.SurfaceGui.TextLabel.Text.. T_C[q]
							wait(0.1)
						end
						wait(v[3]) CLONE_OF_TEXT:Destroy()
					else if (type(v[1]) == "number") then
							H_CUTSCENE.PERFORM_ZOOM(v)
						end
					end 
					end
			end
		end
	end
end




return H_CUTSCENE
