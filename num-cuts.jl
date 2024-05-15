### A Pluto.jl notebook ###
# v0.19.40

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 76233465-1687-4bd9-a5c2-590631451dbe
begin
	import Pkg
	# Pkg.add("PlutoUI")
	Pkg.activate(".")
	Pkg.instantiate()
end

# ╔═╡ 0937c2c8-e3e7-4550-a98f-11db608f29a3
using HDF5,PlutoUI,LinearAlgebra,CairoMakie,Printf,LaTeXStrings

# ╔═╡ af9838f4-6128-404d-8032-c234d2f621aa
begin

filepath0 = "/Volumes/XuDisk/home/PhD/computing/nonlinear/data/eta=0.350_omega=1.4142_cut_profile_r_1e-10.h5"
fid = h5open(filepath0, "r")
data_0 = Dict()

for group in keys(fid)
    group_path = joinpath("/", group)

    r_data = read(fid[joinpath(group_path, "r")])
	z_data = read(fid[joinpath(group_path, "z")])
    rad_data = read(fid[joinpath(group_path, "mean-RadialVelocity")])
    pol_data = read(fid[joinpath(group_path, "mean-PolarVelocity")])
    azi_data = read(fid[joinpath(group_path, "mean-AzimuthalVelocity")])
    data_0[group] = Dict("r" => r_data, "z" => z_data, "rad" => rad_data, "pol" => pol_data, "azi" => azi_data)
end

close(fid)

filepath1 = "/Volumes/XuDisk/home/PhD/computing/nonlinear/data/eta=0.350_omega=1.4142_cut_profile_r_1e-09.h5"
fid = h5open(filepath1, "r")
data_1 = Dict()

for group in keys(fid)
    group_path = joinpath("/", group)

    r_data = read(fid[joinpath(group_path, "r")])
	z_data = read(fid[joinpath(group_path, "z")])
    rad_data = read(fid[joinpath(group_path, "mean-RadialVelocity")])
    pol_data = read(fid[joinpath(group_path, "mean-PolarVelocity")])
    azi_data = read(fid[joinpath(group_path, "mean-AzimuthalVelocity")])
    data_1[group] = Dict("r" => r_data, "z" => z_data, "rad" => rad_data, "pol" => pol_data, "azi" => azi_data)
end

close(fid)

filepath2 = "/Volumes/XuDisk/home/PhD/computing/nonlinear/data/eta=0.350_omega=1.4142_cut_profile_r_1e-08.h5"
fid = h5open(filepath2, "r")
data_2 = Dict()

for group in keys(fid)
    group_path = joinpath("/", group)

    r_data = read(fid[joinpath(group_path, "r")])
	z_data = read(fid[joinpath(group_path, "z")])
    rad_data = read(fid[joinpath(group_path, "mean-RadialVelocity")])
    pol_data = read(fid[joinpath(group_path, "mean-PolarVelocity")])
    azi_data = read(fid[joinpath(group_path, "mean-AzimuthalVelocity")])
    data_2[group] = Dict("r" => r_data, "z" => z_data, "rad" => rad_data, "pol" => pol_data, "azi" => azi_data)
end

close(fid)

filepath3 = "/Volumes/XuDisk/home/PhD/computing/nonlinear/data/eta=0.350_omega=1.4142_cut_profile_r_1e-07.h5"
fid = h5open(filepath3, "r")
data_3 = Dict()

for group in keys(fid)
    group_path = joinpath("/", group)

    r_data = read(fid[joinpath(group_path, "r")])
	z_data = read(fid[joinpath(group_path, "z")])
    rad_data = read(fid[joinpath(group_path, "mean-RadialVelocity")])
    pol_data = read(fid[joinpath(group_path, "mean-PolarVelocity")])
    azi_data = read(fid[joinpath(group_path, "mean-AzimuthalVelocity")])
    data_3[group] = Dict("r" => r_data, "z" => z_data, "rad" => rad_data, "pol" => pol_data, "azi" => azi_data)
end

close(fid)
end

# ╔═╡ 55a57810-d590-4450-ae6a-1acc01b00570
publication_theme() = Theme(
    fontsize=16,
    font="Times New Roman",
    Axis=(
        xlabelsize=20, xlabelpadding=0,
        xgridstyle=:dash, ygridstyle=:dash,
        ylabelsize=20, ylabelpadding=0,
        xtickalign=1, ytickalign=1,
        yticksize=8, xticksize=8,
        xlabel="x", ylabel="y"
    ),
	linewidth=2,
    Legend=(framecolor=(:black, 0.5), backgroundcolor=(:white, 0.5)),
    Colorbar=(ticksize=16, tickalign=1, spinewidth=0.5),
)

# ╔═╡ 2c2c6978-5a6f-4a3a-a44f-dde95ec81345
function phys(num)
	return 2 * real.(num)
end

# ╔═╡ 9b94cfd3-944e-4a58-af21-72adfac6e566
begin
	E0 = 1e-10 
	E1 = 1e-09 
	E2 = 1e-08 
end;

# ╔═╡ ead3c674-5ba5-4c06-bd77-7b6dbba2feb2
p_scale = 10^4

# ╔═╡ f077a76f-e628-4288-a780-0e3c00171e55
eta = 0.35

# ╔═╡ 6d785b45-2a50-4494-a0f8-a6ea44f84a0d
P1 = [0, sqrt(2) * eta]

# ╔═╡ f80b1310-6a0c-4369-a75c-0b30625f9fa2
P2 = [eta / sqrt(2), eta / sqrt(2)]

# ╔═╡ 6e1f4d6f-86de-44ac-b87e-a386883d6a5a
P3 = [eta, 0]

# ╔═╡ bb37e212-cec0-478a-869e-719514ffcc8c
P4 = [(-eta + sqrt(1-eta^2))/sqrt(2), (eta + sqrt(1-eta^2))/sqrt(2)] 

# ╔═╡ 062ea521-983c-4141-b983-8dc93a582199
P5 = [sqrt(2) * eta, 0]

# ╔═╡ 0f178f26-8644-4d8a-99fb-30f3c70dbbed
P7 = [(eta + sqrt(1-eta^2))/sqrt(2), (-eta + sqrt(1-eta^2))/sqrt(2)] 

# ╔═╡ 95117c50-ecea-4268-9b79-a48fbf40390e
@bind p1_scale_r PlutoUI.Slider(-1:0.01:1, default=1/3, show_value=true)

# ╔═╡ 73db3b57-b913-40cd-a8f3-9a5b41b8c2e5
@bind p1_scale_f PlutoUI.Slider(-1:0.01:1, default=-1/2, show_value=true)

# ╔═╡ 6b2e954d-34fc-42c8-83b3-177698d139f3
md"""
# P1 local with r dir
The scaling for the local at $P_1$ point is

$\frac{v_{\phi}}{E^{b}} = \boldsymbol{\mathcal{F}}\left( \frac{r-r_{c}}{E^{a}} \right)$

a is $p1_scale_r and b = $p1_scale_f
"""

# ╔═╡ 99092104-3e95-446b-ba4c-83e53471fb0d
begin
	fig1 = Figure(size=(1500, 400), theme=publication_theme())
    ax1_1 = Axis(fig1[1, 1], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\phi}", title=L"$P_1 - \text{at the local}$")
	lines!(ax1_1, (data_0["P1_l"]["r"] .- P1[1]) / (E0)^(p1_scale_r), phys(data_0["P1_l"]["azi"]) * p_scale / (E0)^(p1_scale_f), label=L"E_{z=0}=1e-10", color=:blue)
	lines!(ax1_1, (data_1["P1_l"]["r"] .- P1[1]) / (E1)^(p1_scale_r), phys(data_1["P1_l"]["azi"]) * p_scale / (E1)^(p1_scale_f), label=L"E_{z=0}=1e-09", color=:red)
	lines!(ax1_1, (data_2["P1_l"]["r"] .- P1[1]) / (E2)^(p1_scale_r), phys(data_2["P1_l"]["azi"]) * p_scale / (E2)^(p1_scale_f), label=L"E_{z=0}=1e-08", color=:green)
	axislegend(ax1_1, position=:rb)
	Label(fig1[1,1, Top()], halign=:left, L"\times 10^{-4}")
	
	ax1_2 = Axis(fig1[1, 2], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\rho}", title=L"$P_1 - \text{at the local}$")
	lines!(ax1_2, (data_0["P1_l"]["r"] .- P1[1]) / (E0)^(p1_scale_r), phys(data_0["P1_l"]["rad"]) * p_scale / (E0)^(p1_scale_f), label=L"E_{z=0}=1e-10", color=:blue)
	lines!(ax1_2, (data_1["P1_l"]["r"] .- P1[1]) / (E1)^(p1_scale_r), phys(data_1["P1_l"]["rad"]) * p_scale / (E1)^(p1_scale_f), label=L"E_{z=0}=1e-09", color=:red)
	lines!(ax1_2, (data_2["P1_l"]["r"] .- P1[1]) / (E2)^(p1_scale_r), phys(data_2["P1_l"]["rad"]) * p_scale / (E2)^(p1_scale_f), label=L"E_{z=0}=1e-08", color=:green)
	Label(fig1[1,2, Top()], halign=:left, L"\times 10^{-4}")
	
	ax1_3 = Axis(fig1[1, 3], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\theta}", title=L"$P_1 - \text{at the local}$")
	lines!(ax1_3, (data_0["P1_l"]["r"] .- P1[1]) / (E0)^(p1_scale_r), phys(data_0["P1_l"]["pol"]) * p_scale / (E0)^(p1_scale_f), label=L"E_{z=0}=1e-10", color=:blue)
	lines!(ax1_3, (data_1["P1_l"]["r"] .- P1[1]) / (E1)^(p1_scale_r), phys(data_1["P1_l"]["pol"]) * p_scale / (E1)^(p1_scale_f), label=L"E_{z=0}=1e-09", color=:red)
	lines!(ax1_3, (data_2["P1_l"]["r"] .- P1[1]) / (E2)^(p1_scale_r), phys(data_2["P1_l"]["pol"]) * p_scale / (E2)^(p1_scale_f), label=L"E_{z=0}=1e-08", color=:green)
	Label(fig1[1,3, Top()], halign=:left, L"\times 10^{-4}")
	save("fig/cuts/p1-l.svg",fig1)
	fig1
end

# ╔═╡ 6664f029-9279-4016-b8db-568f556fc23e
@bind p1_scale_z PlutoUI.Slider(-1:0.01:1, default=1/3, show_value=true)

# ╔═╡ de940f56-875c-4564-b23f-60b6b79fd3ae
@bind p1_scale_fz PlutoUI.Slider(-1:0.01:1, default=-1/2, show_value=true)

# ╔═╡ b2f9c586-942a-4801-ba88-35e359834fad
md"""
# P1 local with z dir
The scaling for the local z at $P_1$ point is

a is $p1_scale_z and b = $p1_scale_fz
"""

# ╔═╡ 957bd58f-5a65-4597-89fa-d96ad8661059
begin
	figa1 = Figure(size=(1500, 400), theme=publication_theme())
    axa1_1 = Axis(figa1[1, 1], xlabel=L"\tilde{z}", ylabel=L"\tilde{v}_{\phi}", title=L"$P_1 - \text{at the local z dir}$")
	lines!(axa1_1, (data_0["P1_z"]["z"] .- P1[2]) / (E0)^(p1_scale_z), phys(data_0["P1_z"]["azi"]) * p_scale / (E0)^(p1_scale_fz), label=L"E_{z=0}=1e-10", color=:blue)
	lines!(axa1_1, (data_1["P1_z"]["z"] .- P1[2]) / (E1)^(p1_scale_z), phys(data_1["P1_z"]["azi"]) * p_scale / (E1)^(p1_scale_fz), label=L"E_{z=0}=1e-09", color=:red)
	lines!(axa1_1, (data_2["P1_z"]["z"] .- P1[2]) / (E2)^(p1_scale_z), phys(data_2["P1_z"]["azi"]) * p_scale / (E2)^(p1_scale_fz), label=L"E_{z=0}=1e-08", color=:green)
	axislegend(axa1_1, position=:rb)
	Label(figa1[1,1, Top()], halign=:left, L"\times 10^{-4}")
	
	axa1_2 = Axis(figa1[1, 2], xlabel=L"\tilde{z}", ylabel=L"\tilde{v}_{\rho}", title=L"$P_1 - \text{at the local z dir}$")
	lines!(axa1_2, (data_0["P1_z"]["z"] .- P1[2]) / (E0)^(p1_scale_z), phys(data_0["P1_z"]["rad"]) * p_scale / (E0)^(p1_scale_fz), label=L"E_{z=0}=1e-10", color=:blue)
	lines!(axa1_2, (data_1["P1_z"]["z"] .- P1[2]) / (E1)^(p1_scale_z), phys(data_1["P1_z"]["rad"]) * p_scale / (E1)^(p1_scale_fz), label=L"E_{z=0}=1e-09", color=:red)
	lines!(axa1_2, (data_2["P1_z"]["z"] .- P1[2]) / (E2)^(p1_scale_z), phys(data_2["P1_z"]["rad"]) * p_scale / (E2)^(p1_scale_fz), label=L"E_{z=0}=1e-08", color=:green)
	Label(figa1[1,2, Top()], halign=:left, L"\times 10^{-4}")
	
	axa1_3 = Axis(figa1[1, 3], xlabel=L"\tilde{z}", ylabel=L"\tilde{v}_{\theta}", title=L"$P_1 - \text{at the local z dir}$")
	lines!(axa1_3, (data_0["P1_z"]["z"] .- P1[2]) / (E0)^(p1_scale_z), phys(data_0["P1_z"]["pol"]) * p_scale / (E0)^(p1_scale_fz), label=L"E_{z=0}=1e-10", color=:blue)
	lines!(axa1_3, (data_1["P1_z"]["z"] .- P1[2]) / (E1)^(p1_scale_z), phys(data_1["P1_z"]["pol"]) * p_scale / (E1)^(p1_scale_fz), label=L"E_{z=0}=1e-09", color=:red)
	lines!(axa1_3, (data_2["P1_z"]["z"] .- P1[2]) / (E2)^(p1_scale_z), phys(data_2["P1_z"]["pol"]) * p_scale / (E2)^(p1_scale_fz), label=L"E_{z=0}=1e-08", color=:green)
	Label(figa1[1,3, Top()], halign=:left, L"\times 10^{-4}")
	save("fig/cuts/p1-z.svg",figa1)
	figa1
end

# ╔═╡ a10dc5fc-5416-448e-b360-b1d6518d69c0
@bind p1_scale_r1 PlutoUI.Slider(-1:0.01:1, default=1/3, show_value=true)

# ╔═╡ 2ad49a94-8a47-4df9-be17-b8840cf5d843
@bind p1_scale_f1 PlutoUI.Slider(-1:0.01:1, default=-0.2, show_value=true)

# ╔═╡ ee17b65f-e5d6-4fce-bce7-395b6c5f4aa8
md"""
# $P_1$ in the bulk
The scaling for the $P_1$ in the bulk is
For the velocity $v_{\phi}$ a1 is $p1_scale_r1 and b1 = $p1_scale_f1

For the velocity $v_{\rho}$ a1 is 1/3 and b1 = -1/10

For the velocity $v_{\theta}$ a1 is 1/3 and b1 = 1/5
"""

# ╔═╡ 90f6ccb0-52a4-41b3-8337-17b7f4fcc694
begin
	fig1_1 = Figure(size=(1500, 400), theme=publication_theme())
    ax1_1_1 = Axis(fig1_1[1, 1], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\phi}", title=L"$P_{1} -\text{in the bulk}$")
	lines!(ax1_1_1, (data_0["P1_b"]["r"] .- P1[1]) / (E0)^(p1_scale_r1), phys(data_0["P1_b"]["azi"]) * p_scale / (E0)^(p1_scale_f1), label=L"E_{z=0.4}=1e-10", color=:blue)
	lines!(ax1_1_1, (data_1["P1_b"]["r"] .- P1[1]) / (E1)^(p1_scale_r1), phys(data_1["P1_b"]["azi"]) * p_scale / (E1)^(p1_scale_f1), label=L"E_{z=0.4}=1e-09", color=:red)
	lines!(ax1_1_1, (data_2["P1_b"]["r"] .- P1[1]) / (E2)^(p1_scale_r1), phys(data_2["P1_b"]["azi"]) * p_scale / (E2)^(p1_scale_f1), label=L"E_{z=0.4}=1e-08", color=:green)
	axislegend(ax1_1_1, position=:rb)
	Label(fig1_1[1,1, Top()], halign=:left, L"\times 10^{-4}")
	
	ax1_1_2 = Axis(fig1_1[1, 2], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\rho}", title=L"$P_{1} -\text{in the bulk}$")
	lines!(ax1_1_2, (data_0["P1_b"]["r"] .- P1[1]) / (E0)^(1/3), phys(data_0["P1_b"]["rad"]) * p_scale / (E0)^(-1/10), label=L"E_{z=0.4}=1e-10", color=:blue)
	lines!(ax1_1_2, (data_1["P1_b"]["r"] .- P1[1]) / (E1)^(1/3), phys(data_1["P1_b"]["rad"]) * p_scale / (E1)^(-1/10), label=L"E_{z=0.4}=1e-09", color=:red)
	lines!(ax1_1_2, (data_2["P1_b"]["r"] .- P1[1]) / (E2)^(1/3), phys(data_2["P1_b"]["rad"]) * p_scale / (E2)^(-1/10), label=L"E_{z=0.4}=1e-08", color=:green)
	Label(fig1_1[1,2, Top()], halign=:left, L"\times 10^{-4}")
	
	ax1_1_3 = Axis(fig1_1[1, 3], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\theta}", title=L"$P_{1} -\text{in the bulk}$")
	# lines!(ax1_1_3, (data_0["P1_b"]["r"] .- P1[1]) / (E0)^(1/3), phys(data_0["P1_b"]["pol"]) * p_scale / (E0)^(1/5), label=L"E_{z=0}=1e-10", color=:blue)
	lines!(ax1_1_3, (data_1["P1_b"]["r"] .- P1[1]) / (E1)^(1/3), phys(data_1["P1_b"]["pol"]) * p_scale / (E1)^(1/5), label=L"E_{z=0}=1e-09", color=:red)
	lines!(ax1_1_3, (data_2["P1_b"]["r"] .- P1[1]) / (E2)^(1/3), phys(data_2["P1_b"]["pol"]) * p_scale / (E2)^(1/5), label=L"E_{z=0}=1e-08", color=:green)
	Label(fig1_1[1,3, Top()], halign=:left, L"\times 10^{-4}")
	save("fig/cuts/p1-b.svg",fig1_1)
	fig1_1
end

# ╔═╡ ddf67200-ec8c-44f4-a39d-033e301e59dc
begin
	f1_1 = Figure(size=(1500, 400), theme=publication_theme())
    a1_1_1 = Axis(f1_1[1, 1], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\phi}", title=L"$P_{1} -\text{in the bulk}$")
	lines!(a1_1_1, (data_0["P1_b"]["r"] .- P1[1]) / (E0)^(1/6), phys(data_0["P1_b"]["azi"]) * p_scale / (E0)^(0), label=L"E_{z=0.4}=1e-10", color=:blue)
	lines!(a1_1_1, (data_1["P1_b"]["r"] .- P1[1]) / (E1)^(1/6), phys(data_1["P1_b"]["azi"]) * p_scale / (E1)^(0), label=L"E_{z=0.4}=1e-09", color=:red)
	lines!(a1_1_1, (data_2["P1_b"]["r"] .- P1[1]) / (E2)^(1/6), phys(data_2["P1_b"]["azi"]) * p_scale / (E2)^(0), label=L"E_{z=0.4}=1e-08", color=:green)
	axislegend(a1_1_1, position=:rb)
	Label(f1_1[1,1, Top()], halign=:left, L"\times 10^{-4}")
	
	a1_1_2 = Axis(f1_1[1, 2], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\rho}", title=L"$P_{1} -\text{in the bulk}$")
	lines!(a1_1_2, (data_0["P1_b"]["r"] .- P1[1]) / (E0)^(1/3), phys(data_0["P1_b"]["rad"]) * p_scale / (E0)^(-1/10), label=L"E_{z=0.4}=1e-10", color=:blue)
	lines!(a1_1_2, (data_1["P1_b"]["r"] .- P1[1]) / (E1)^(1/3), phys(data_1["P1_b"]["rad"]) * p_scale / (E1)^(-1/10), label=L"E_{z=0.4}=1e-09", color=:red)
	lines!(a1_1_2, (data_2["P1_b"]["r"] .- P1[1]) / (E2)^(1/3), phys(data_2["P1_b"]["rad"]) * p_scale / (E2)^(-1/10), label=L"E_{z=0.4}=1e-08", color=:green)
	Label(f1_1[1,2, Top()], halign=:left, L"\times 10^{-4}")
	
	a1_1_3 = Axis(f1_1[1, 3], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\theta}", title=L"$P_{1} -\text{in the bulk}$")
	# lines!(a1_1_3, (data_0["P1_b"]["r"] .- P1[1]) / (E0)^(1/3), phys(data_0["P1_b"]["pol"]) * p_scale / (E0)^(1/5), label=L"E_{z=0}=1e-10", color=:blue)
	lines!(a1_1_3, (data_1["P1_b"]["r"] .- P1[1]) / (E1)^(1/3), phys(data_1["P1_b"]["pol"]) * p_scale / (E1)^(1/5), label=L"E_{z=0}=1e-09", color=:red)
	lines!(a1_1_3, (data_2["P1_b"]["r"] .- P1[1]) / (E2)^(1/3), phys(data_2["P1_b"]["pol"]) * p_scale / (E2)^(1/5), label=L"E_{z=0}=1e-08", color=:green)
	Label(f1_1[1,3, Top()], halign=:left, L"\times 10^{-4}")
	save("fig/cuts/p1-b-b.svg",f1_1)
	f1_1
end

# ╔═╡ 620b8d2c-d244-4fe7-94dc-9ebd9ce5862a
@bind p2_scale_r1 PlutoUI.Slider(-1:0.01:1, default=1/4, show_value=true)

# ╔═╡ d0ddfb3b-1a2c-4bcb-876b-e5eeae97daac
@bind p2_scale_f1 PlutoUI.Slider(-1:0.01:1, default=-0.1, show_value=true)

# ╔═╡ 0d938568-3fa3-41e4-9df5-c0526912fc85
md"""
# P2 in the bulk
The scaling of the $P_2$ of velocity $v_{\phi}$ in the bulk is a1 = $p2_scale_r1 and b1 = $p2_scale_f1 

For the velocity $v_{\rho}$ and $v_{\theta}$ is a2 = 1/5 and b2 = 1/5
"""

# ╔═╡ 26685987-f5a7-4606-b46d-e57e42013000
begin
	fig2_1 = Figure(size=(1500, 400), theme=publication_theme())
    ax2_1_1 = Axis(fig2_1[1, 1], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\phi}", title=L"$P_{2} -\text{in the bulk}$")
	lines!(ax2_1_1, (data_0["P2_b"]["r"] .- P2[1]) / (E0)^(p2_scale_r1), phys(data_0["P2_b"]["azi"]) * p_scale / (E0)^(p2_scale_f1), label=L"E_{z=0.4}=1e-10", color=:blue)
	lines!(ax2_1_1, (data_1["P2_b"]["r"] .- P2[1]) / (E1)^(p2_scale_r1), phys(data_1["P2_b"]["azi"]) * p_scale / (E1)^(p2_scale_f1), label=L"E_{z=0.4}=1e-09", color=:red)
	lines!(ax2_1_1, (data_2["P2_b"]["r"] .- P2[1]) / (E2)^(p2_scale_r1), phys(data_2["P2_b"]["azi"]) * p_scale / (E2)^(p2_scale_f1), label=L"E_{z=0.4}=1e-08", color=:green)
	axislegend(ax2_1_1, position=:rt)
	Label(fig2_1[1,1, Top()], halign=:left, L"\times 10^{-4}")
	
	ax2_1_2 = Axis(fig2_1[1, 2], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\rho}", title=L"$P_{2} -\text{in the bulk}$")
	lines!(ax2_1_2, (data_0["P2_b"]["r"] .- P2[1]) / (E0)^(1/5), phys(data_0["P2_b"]["rad"]) * p_scale / (E0)^(1/5), label=L"E_{z=0.4}=1e-10", color=:blue)
	lines!(ax2_1_2, (data_1["P2_b"]["r"] .- P2[1]) / (E1)^(1/5), phys(data_1["P2_b"]["rad"]) * p_scale / (E1)^(1/5), label=L"E_{z=0.4}=1e-09", color=:red)
	lines!(ax2_1_2, (data_2["P2_b"]["r"] .- P2[1]) / (E2)^(1/5), phys(data_2["P2_b"]["rad"]) * p_scale / (E2)^(1/5), label=L"E_{z=0.4}=1e-08", color=:green)
	Label(fig2_1[1,2, Top()], halign=:left, L"\times 10^{-4}")
	
	ax2_1_3 = Axis(fig2_1[1, 3], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\theta}", title=L"$P_{2} -\text{in the bulk}$")
	lines!(ax2_1_3, (data_0["P2_b"]["r"] .- P2[1]) / (E0)^(1/5), phys(data_0["P2_b"]["pol"]) * p_scale / (E0)^(1/5), label=L"E_{z=0}=1e-10", color=:blue)
	lines!(ax2_1_3, (data_1["P2_b"]["r"] .- P2[1]) / (E1)^(1/5), phys(data_1["P2_b"]["pol"]) * p_scale / (E1)^(1/5), label=L"E_{z=0}=1e-09", color=:red)
	lines!(ax2_1_3, (data_2["P2_b"]["r"] .- P2[1]) / (E2)^(1/5), phys(data_2["P2_b"]["pol"]) * p_scale / (E2)^(1/5), label=L"E_{z=0}=1e-08", color=:green)
	Label(fig2_1[1,3, Top()], halign=:left, L"\times 10^{-4}")
	save("fig/cuts/p2-b.svg",fig2_1)
	fig2_1
end

# ╔═╡ 81c35893-e375-4240-b29a-b89ee99f7c3d
@bind p2_scale_lr PlutoUI.Slider(-1:0.01:1, default=1/3, show_value=true)

# ╔═╡ 4726485e-c5ac-49b0-9749-8039fdae6bba
@bind p2_scale_flr PlutoUI.Slider(-1:0.01:1, default=-1/20, show_value=true)

# ╔═╡ 04b5bb63-6932-4e93-94b2-28e88d3bab10
md"""
# P2 local with r dir
The scaling of the $P_2$ of velocity $v_{\phi}$ local with r dir is a1 = $p2_scale_lr and b2 = $p2_scale_flr

For the velocity $v_{\rho}$ is a2 = 2/5 and b2 = 1/5 and $v_{\theta}$ a3 = 2/5 b3 = -1/5
"""

# ╔═╡ ac720d29-a226-4109-ac04-bea8b53b662f
begin
	figa2_1 = Figure(size=(1500, 400), theme=publication_theme())
    axa2_1 = Axis(figa2_1[1, 1], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\phi}", title=L"$P_{2} -\text{local r dir}$")
	lines!(axa2_1, (data_0["P2_lr"]["r"] .- P2[1]) / (E0)^(p2_scale_lr), phys(data_0["P2_lr"]["azi"]) * p_scale / (E0)^(p2_scale_flr), label=L"E_{z=0.4}=1e-10", color=:blue)
	lines!(axa2_1, (data_1["P2_lr"]["r"] .- P2[1]) / (E1)^(p2_scale_lr), phys(data_1["P2_lr"]["azi"]) * p_scale / (E1)^(p2_scale_flr), label=L"E_{z=0.4}=1e-09", color=:red)
	lines!(axa2_1, (data_2["P2_lr"]["r"] .- P2[1]) / (E2)^(p2_scale_lr), phys(data_2["P2_lr"]["azi"]) * p_scale / (E2)^(p2_scale_flr), label=L"E_{z=0.4}=1e-08", color=:green)
	axislegend(axa2_1, position=:rt)
	Label(figa2_1[1,1, Top()], halign=:left, L"\times 10^{-4}")
	xlims!(0,2)
	
	axa2_2 = Axis(figa2_1[1, 2], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\rho}", title=L"$P_{2} -\text{local r dir}$")
	lines!(axa2_2, (data_0["P2_lr"]["r"] .- P2[1]) / (E0)^(2/5), phys(data_0["P2_lr"]["rad"]) * p_scale / (E0)^(1/5), label=L"E_{z=0.4}=1e-10", color=:blue)
	lines!(axa2_2, (data_1["P2_lr"]["r"] .- P2[1]) / (E1)^(2/5), phys(data_1["P2_lr"]["rad"]) * p_scale / (E1)^(1/5), label=L"E_{z=0.4}=1e-09", color=:red)
	lines!(axa2_2, (data_2["P2_lr"]["r"] .- P2[1]) / (E2)^(2/5), phys(data_2["P2_lr"]["rad"]) * p_scale / (E2)^(1/5), label=L"E_{z=0.4}=1e-08", color=:green)
	Label(figa2_1[1,2, Top()], halign=:left, L"\times 10^{-4}")
	xlims!(0,10)
	
	
	axa2_3 = Axis(figa2_1[1, 3], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\theta}", title=L"$P_{2} -\text{local r dir}$")
	lines!(axa2_3, (data_0["P2_lr"]["r"] .- P2[1]) / (E0)^(2/5), phys(data_0["P2_lr"]["pol"]) * p_scale / (E0)^(-1/5), label=L"E_{z=0}=1e-10", color=:blue)
	lines!(axa2_3, (data_1["P2_lr"]["r"] .- P2[1]) / (E1)^(2/5), phys(data_1["P2_lr"]["pol"]) * p_scale / (E1)^(-1/5), label=L"E_{z=0}=1e-09", color=:red)
	lines!(axa2_3, (data_2["P2_lr"]["r"] .- P2[1]) / (E2)^(2/5), phys(data_2["P2_lr"]["pol"]) * p_scale / (E2)^(-1/5), label=L"E_{z=0}=1e-08", color=:green)
	Label(figa2_1[1,3, Top()], halign=:left, L"\times 10^{-4}")
	xlims!(0,5)
	save("fig/cuts/p2-lr.svg",figa2_1)
	figa2_1
end

# ╔═╡ e9f37fbd-db1e-45b5-bc04-45acf580a322
@bind p2_scale_lz PlutoUI.Slider(-1:0.01:1, default=1/3, show_value=true)

# ╔═╡ 44f4d3d4-e508-453f-b056-ead68f0f3127
@bind p2_scale_flz PlutoUI.Slider(-1:0.01:1, default=-1/20, show_value=true)

# ╔═╡ ac06f1fb-608e-4516-a8f2-d73978fd4617
md"""
# P2 local with z dir
The scaling of the $P_2$ of velocity $v_{\phi}$ local with z dir is a1 = $p2_scale_lz and b2 = $p2_scale_flz

For the velocity $v_{\rho}$ is a2 = 2/5 and b2 = 1/5 and $v_{\theta}$ a3 = 2/5 b3 = -1/5
"""

# ╔═╡ 216989ea-3716-4f8c-b706-2cad9f86c096
begin
	figa2_2 = Figure(size=(1500, 400), theme=publication_theme())
    axa3_1 = Axis(figa2_2[1, 1], xlabel=L"\tilde{z}", ylabel=L"\tilde{v}_{\phi}", title=L"$P_{2} -\text{local z dir}$")
	lines!(axa3_1, (data_0["P2_lz"]["z"] .- P2[1]) / (E0)^(p2_scale_lz), phys(data_0["P2_lz"]["azi"]) * p_scale / (E0)^(p2_scale_flz), label=L"E_{z=0.4}=1e-10", color=:blue)
	lines!(axa3_1, (data_1["P2_lz"]["z"] .- P2[1]) / (E1)^(p2_scale_lz), phys(data_1["P2_lz"]["azi"]) * p_scale / (E1)^(p2_scale_flz), label=L"E_{z=0.4}=1e-09", color=:red)
	lines!(axa3_1, (data_2["P2_lz"]["z"] .- P2[1]) / (E2)^(p2_scale_lz), phys(data_2["P2_lz"]["azi"]) * p_scale / (E2)^(p2_scale_flz), label=L"E_{z=0.4}=1e-08", color=:green)
	axislegend(axa3_1, position=:rt)
	Label(figa2_2[1,1, Top()], halign=:left, L"\times 10^{-4}")
	xlims!(0,2)
	
	axa3_2 = Axis(figa2_2[1, 2], xlabel=L"\tilde{z}", ylabel=L"\tilde{v}_{\rho}", title=L"$P_{2} -\text{local z dir}$")
	lines!(axa3_2, (data_0["P2_lz"]["z"] .- P2[1]) / (E0)^(2/5), phys(data_0["P2_lz"]["rad"]) * p_scale / (E0)^(1/5), label=L"E_{z=0.4}=1e-10", color=:blue)
	lines!(axa3_2, (data_1["P2_lz"]["z"] .- P2[1]) / (E1)^(2/5), phys(data_1["P2_lz"]["rad"]) * p_scale / (E1)^(1/5), label=L"E_{z=0.4}=1e-09", color=:red)
	lines!(axa3_2, (data_2["P2_lz"]["z"] .- P2[1]) / (E2)^(2/5), phys(data_2["P2_lz"]["rad"]) * p_scale / (E2)^(1/5), label=L"E_{z=0.4}=1e-08", color=:green)
	Label(figa2_2[1,2, Top()], halign=:left, L"\times 10^{-4}")
	xlims!(0,10)
	
	
	axa3_3 = Axis(figa2_2[1, 3], xlabel=L"\tilde{z}", ylabel=L"\tilde{v}_{\theta}", title=L"$P_{2} -\text{local z dir}$")
	lines!(axa3_3, (data_0["P2_lz"]["z"] .- P2[1]) / (E0)^(2/5), phys(data_0["P2_lz"]["pol"]) * p_scale / (E0)^(-1/5), label=L"E_{z=0}=1e-10", color=:blue)
	lines!(axa3_3, (data_1["P2_lz"]["z"] .- P2[1]) / (E1)^(2/5), phys(data_1["P2_lz"]["pol"]) * p_scale / (E1)^(-1/5), label=L"E_{z=0}=1e-09", color=:red)
	lines!(axa3_3, (data_2["P2_lz"]["z"] .- P2[1]) / (E2)^(2/5), phys(data_2["P2_lz"]["pol"]) * p_scale / (E2)^(-1/5), label=L"E_{z=0}=1e-08", color=:green)
	Label(figa2_2[1,3, Top()], halign=:left, L"\times 10^{-4}")
	xlims!(0,5)
	save("fig/cuts/p2-lz.svg",figa2_2)
	figa2_2
end

# ╔═╡ e245323f-ea7a-499f-9702-64a7f26b55b8
@bind p3_scale_r PlutoUI.Slider(-1:0.01:1, default=1/3, show_value=true)

# ╔═╡ f26438a3-1a40-4084-945d-103ed7442630
@bind p3_scale_f PlutoUI.Slider(-1:0.01:1, default=-1/20, show_value=true)

# ╔═╡ 5f0493d0-82fe-4881-85cc-f44a067e3a44
md"""
# P3 at local
The scaling of the $P_3$ of velocity $v_{\phi}$ at local is a1 = $p3_scale_r and b1 = $p3_scale_f

For the velocity $v_{\rho}$ is a2 = 1/3 and b2 = 1/4 ,and $v_{\theta}$ is small we don't care.
"""

# ╔═╡ f569601e-60d8-4214-b1a0-9c50787537c2
begin
	fig3_1 = Figure(size=(1500, 400), theme=publication_theme())
    ax3_1 = Axis(fig3_1[1, 1], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\phi}", title=L"$P_{3} -\text{at the local}$")
	lines!(ax3_1, (data_0["P3_l"]["r"] .- P3[1]) / (E0)^(p3_scale_r), phys(data_0["P3_l"]["azi"]) * p_scale / (E0)^(p3_scale_f), label=L"E_{z=0}=1e-10", color=:blue)
	lines!(ax3_1, (data_1["P3_l"]["r"] .- P3[1]) / (E1)^(p3_scale_r), phys(data_1["P3_l"]["azi"]) * p_scale / (E1)^(p3_scale_f), label=L"E_{z=0}=1e-09", color=:red)
	lines!(ax3_1, (data_2["P3_l"]["r"] .- P3[1]) / (E2)^(p3_scale_r), phys(data_2["P3_l"]["azi"]) * p_scale / (E2)^(p3_scale_f), label=L"E_{z=0}=1e-08", color=:green)
	axislegend(ax3_1, position=:rt)
	Label(fig3_1[1,1, Top()], halign=:left, L"\times 10^{-4}")
	xlims!(0,1)
	
	ax3_2 = Axis(fig3_1[1, 2], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\rho}", title=L"$P_{3} -\text{at the local}$")
	lines!(ax3_2, (data_0["P3_l"]["r"] .- P3[1]) / (E0)^(1/3), phys(data_0["P3_l"]["rad"]) * p_scale / (E0)^(1/4), label=L"E_{z=0}=1e-10", color=:blue)
	lines!(ax3_2, (data_1["P3_l"]["r"] .- P3[1]) / (E1)^(1/3), phys(data_1["P3_l"]["rad"]) * p_scale / (E1)^(1/4), label=L"E_{z=0}=1e-09", color=:red)
	lines!(ax3_2, (data_2["P3_l"]["r"] .- P3[1]) / (E2)^(1/3), phys(data_2["P3_l"]["rad"]) * p_scale / (E2)^(1/4), label=L"E_{z=0}=1e-08", color=:green)
	Label(fig3_1[1,2, Top()], halign=:left, L"\times 10^{-4}")
	xlims!(0,1)
	
	ax3_3 = Axis(fig3_1[1, 3], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\theta}", title=L"$P_{3} -\text{at the local}$")
	lines!(ax3_3, (data_0["P3_l"]["r"] .- P3[1]) / (E0)^(1/3), phys(data_0["P3_l"]["pol"]) * p_scale / (E0)^(1/4), label=L"E_{z=0}=1e-10", color=:blue)
	lines!(ax3_3, (data_1["P3_l"]["r"] .- P3[1]) / (E1)^(1/3), phys(data_1["P3_l"]["pol"]) * p_scale / (E1)^(1/4), label=L"E_{z=0}=1e-09", color=:red)
	lines!(ax3_3, (data_2["P3_l"]["r"] .- P3[1]) / (E2)^(1/3), phys(data_2["P3_l"]["pol"]) * p_scale / (E2)^(1/4), label=L"E_{z=0}=1e-08", color=:green)
	Label(fig3_1[1,3, Top()], halign=:left, L"\times 10^{-4}")
	xlims!(0,1)
	save("fig/cuts/p3-l.svg",fig3_1)
	fig3_1
end

# ╔═╡ 6145aa89-2522-404d-a1bd-846fb9ed76bf
@bind p3_scale_r1 PlutoUI.Slider(-1:0.01:1, default=1/4, show_value=true)

# ╔═╡ f121447e-c036-4a37-b7a5-3b9a82846c8f
@bind p3_scale_f1 PlutoUI.Slider(-1:0.01:1, default=-1/20, show_value=true)

# ╔═╡ 6468b992-018d-47ec-8a7b-4b91af2ecc23
md"""
# P3 in the bulk
The scaling of the $P_3$ of velocity $v_{\phi}$ in the bulk is a1 = $p3_scale_r1 and b1 = $p3_scale_f1

For the velocity $v_{\rho}$ is a2 = 1/3 and b2 = 1/8 ,and $v_{\theta}$ is same with $v_{\rho}$
"""

# ╔═╡ 191ede80-1b4f-4c37-abb5-dbcea42d9386
begin
	fig3_1_1 = Figure(size=(1500, 400), theme=publication_theme())
    ax3_1_1 = Axis(fig3_1_1[1, 1], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\phi}", title=L"$P_{3} -\text{in the bulk}$")
	lines!(ax3_1_1, (data_0["P3_b"]["r"] .- P3[1]) / (E0)^(p3_scale_r1), phys(data_0["P3_b"]["azi"]) * p_scale / (E0)^(p3_scale_f1), label=L"E_{z=0.4}=1e-10", color=:blue)
	lines!(ax3_1_1, (data_1["P3_b"]["r"] .- P3[1]) / (E1)^(p3_scale_r1), phys(data_1["P3_b"]["azi"]) * p_scale / (E1)^(p3_scale_f1), label=L"E_{z=0.4}=1e-09", color=:red)
	lines!(ax3_1_1, (data_2["P3_b"]["r"] .- P3[1]) / (E2)^(p3_scale_r1), phys(data_2["P3_b"]["azi"]) * p_scale / (E2)^(p3_scale_f1), label=L"E_{z=0.4}=1e-08", color=:green)
	axislegend(ax3_1_1, position=:rb)
	Label(fig3_1_1[1,1, Top()], halign=:left, L"\times 10^{-4}")
	
	ax3_1_2 = Axis(fig3_1_1[1, 2], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\rho}", title=L"$P_{3} -\text{in the bulk}$")
	lines!(ax3_1_2, (data_0["P3_b"]["r"] .- P3[1]) / (E0)^(1/3), phys(data_0["P3_b"]["rad"]) * p_scale / (E0)^(1/8), label=L"E_{z=0.4}=1e-10", color=:blue)
	lines!(ax3_1_2, (data_1["P3_b"]["r"] .- P3[1]) / (E1)^(1/3), phys(data_1["P3_b"]["rad"]) * p_scale / (E1)^(1/8), label=L"E_{z=0.4}=1e-09", color=:red)
	lines!(ax3_1_2, (data_2["P3_b"]["r"] .- P3[1]) / (E2)^(1/3), phys(data_2["P3_b"]["rad"]) * p_scale / (E2)^(1/8), label=L"E_{z=0.4}=1e-08", color=:green)
	Label(fig3_1_1[1,2, Top()], halign=:left, L"\times 10^{-4}")
	# xlims!(-2,2)
	
	ax3_1_3 = Axis(fig3_1_1[1, 3], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\theta}", title=L"$P_{3} -\text{in the bulk}$")
	lines!(ax3_1_3, (data_0["P3_b"]["r"] .- P3[1]) / (E0)^(1/3), phys(data_0["P3_b"]["pol"]) * p_scale / (E0)^(1/8), label=L"E_{z=0}=1e-10", color=:blue)
	lines!(ax3_1_3, (data_1["P3_b"]["r"] .- P3[1]) / (E1)^(1/3), phys(data_1["P3_b"]["pol"]) * p_scale / (E1)^(1/8), label=L"E_{z=0}=1e-09", color=:red)
	lines!(ax3_1_3, (data_2["P3_b"]["r"] .- P3[1]) / (E2)^(1/3), phys(data_2["P3_b"]["pol"]) * p_scale / (E2)^(1/8), label=L"E_{z=0}=1e-08", color=:green)
	Label(fig3_1_1[1,3, Top()], halign=:left, L"\times 10^{-4}")
	# xlims!(-2,2)
	save("fig/cuts/p3-b.svg",fig3_1_1)
	fig3_1_1
end

# ╔═╡ a6337d25-02d7-49e7-83dc-b73de7b37bca
begin
	f3_1_1 = Figure(size=(1500, 400), theme=publication_theme())
    a3_1_1 = Axis(f3_1_1[1, 1], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\phi}", title=L"$P_{3} -\text{in the bulk}$")
	lines!(a3_1_1, (data_0["P3_b"]["r"] .- P3[1]) / (E0)^(1/10), phys(data_0["P3_b"]["azi"]) * p_scale / (E0)^(p3_scale_f1), label=L"E_{z=0.4}=1e-10", color=:blue)
	lines!(a3_1_1, (data_1["P3_b"]["r"] .- P3[1]) / (E1)^(1/10), phys(data_1["P3_b"]["azi"]) * p_scale / (E1)^(p3_scale_f1), label=L"E_{z=0.4}=1e-09", color=:red)
	lines!(a3_1_1, (data_2["P3_b"]["r"] .- P3[1]) / (E2)^(1/10), phys(data_2["P3_b"]["azi"]) * p_scale / (E2)^(p3_scale_f1), label=L"E_{z=0.4}=1e-08", color=:green)
	axislegend(a3_1_1, position=:rb)
	Label(f3_1_1[1,1, Top()], halign=:left, L"\times 10^{-4}")
	
	a3_1_2 = Axis(f3_1_1[1, 2], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\rho}", title=L"$P_{3} -\text{in the bulk}$")
	lines!(a3_1_2, (data_0["P3_b"]["r"] .- P3[1]) / (E0)^(1/3), phys(data_0["P3_b"]["rad"]) * p_scale / (E0)^(1/8), label=L"E_{z=0.4}=1e-10", color=:blue)
	lines!(a3_1_2, (data_1["P3_b"]["r"] .- P3[1]) / (E1)^(1/3), phys(data_1["P3_b"]["rad"]) * p_scale / (E1)^(1/8), label=L"E_{z=0.4}=1e-09", color=:red)
	lines!(a3_1_2, (data_2["P3_b"]["r"] .- P3[1]) / (E2)^(1/3), phys(data_2["P3_b"]["rad"]) * p_scale / (E2)^(1/8), label=L"E_{z=0.4}=1e-08", color=:green)
	Label(f3_1_1[1,2, Top()], halign=:left, L"\times 10^{-4}")
	# xlims!(-2,2)
	
	a3_1_3 = Axis(f3_1_1[1, 3], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\theta}", title=L"$P_{3} -\text{in the bulk}$")
	lines!(a3_1_3, (data_0["P3_b"]["r"] .- P3[1]) / (E0)^(1/3), phys(data_0["P3_b"]["pol"]) * p_scale / (E0)^(1/8), label=L"E_{z=0}=1e-10", color=:blue)
	lines!(a3_1_3, (data_1["P3_b"]["r"] .- P3[1]) / (E1)^(1/3), phys(data_1["P3_b"]["pol"]) * p_scale / (E1)^(1/8), label=L"E_{z=0}=1e-09", color=:red)
	lines!(a3_1_3, (data_2["P3_b"]["r"] .- P3[1]) / (E2)^(1/3), phys(data_2["P3_b"]["pol"]) * p_scale / (E2)^(1/8), label=L"E_{z=0}=1e-08", color=:green)
	Label(f3_1_1[1,3, Top()], halign=:left, L"\times 10^{-4}")
	# xlims!(-2,2)
	save("fig/cuts/p3-b-b.svg",f3_1_1)
	f3_1_1
end

# ╔═╡ 776924cb-1ebc-4529-9f2c-41d9008375f5
@bind p4_scale_r PlutoUI.Slider(-1:0.01:1, default=1/3, show_value=true)

# ╔═╡ d669b223-d13c-4f97-b794-f0e97abe1645
@bind p4_scale_f PlutoUI.Slider(-1:0.01:1, default=0, show_value=true)

# ╔═╡ 2db5578c-51de-49c3-9491-00e2357b4ae0
md"""
# P4 at equator
The scaling of the $P_4$ of velocity $v_{\phi}$ at local is a1 = $p4_scale_r and b1 = $p4_scale_f

For the velocity $v_{\rho}$ is a2 = 1/3 and b2 = 1/3 ,and $v_{\theta}$ is small
"""

# ╔═╡ 93d85478-2e5b-425e-8290-b9045dadb375
begin
	fig4_1 = Figure(size=(1500, 400), theme=publication_theme())
    ax4_1 = Axis(fig4_1[1, 1], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\phi}", title=L"$P_{4} -\text{at the equator}$")
	lines!(ax4_1, (data_0["P4_e"]["r"] .- P4[1]) / (E0)^(p4_scale_r), phys(data_0["P4_e"]["azi"]) * p_scale / (E0)^(p4_scale_f), label=L"E_{z=0}=1e-10", color=:blue)
	lines!(ax4_1, (data_1["P4_e"]["r"] .- P4[1]) / (E1)^(p4_scale_r), phys(data_1["P4_e"]["azi"]) * p_scale / (E1)^(p4_scale_f), label=L"E_{z=0}=1e-09", color=:red)
	lines!(ax4_1, (data_2["P4_e"]["r"] .- P4[1]) / (E2)^(p4_scale_r), phys(data_2["P4_e"]["azi"]) * p_scale / (E2)^(p4_scale_f), label=L"E_{z=0}=1e-08", color=:green)
	axislegend(ax4_1, position=:rb)
	Label(fig4_1[1,1, Top()], halign=:left, L"\times 10^{-4}")
	
	ax4_2 = Axis(fig4_1[1, 2], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\rho}", title=L"$P_{4} -\text{at the equator}$")
	# lines!(ax4_2, (data_0["P4_e"]["r"] .- P4[1]) / (E0)^(1/3), phys(data_0["P4_e"]["rad"]) * p_scale / (E0)^(1/3), label=L"E_{z=0.4}=1e-10", color=:blue)
	lines!(ax4_2, (data_1["P4_e"]["r"] .- P4[1]) / (E1)^(1/3), phys(data_1["P4_e"]["rad"]) * p_scale / (E1)^(1/3), label=L"E_{z=0.4}=1e-09", color=:red)
	lines!(ax4_2, (data_2["P4_e"]["r"] .- P4[1]) / (E2)^(1/3), phys(data_2["P4_e"]["rad"]) * p_scale / (E2)^(1/3), label=L"E_{z=0.4}=1e-08", color=:green)
	Label(fig4_1[1,2, Top()], halign=:left, L"\times 10^{-4}")
	# xlims!(-2,2)
	
	ax4_3 = Axis(fig4_1[1, 3], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\theta}", title=L"$P_{4} -\text{at the equator}$")
	# lines!(ax4_3, (data_0["P4_e"]["r"] .- P4[1]) / (E0)^(1/3), phys(data_0["P4_e"]["pol"]) * p_scale / (E0)^(1/3), label=L"E_{z=0}=1e-10", color=:blue)
	lines!(ax4_3, (data_1["P4_e"]["r"] .- P4[1]) / (E1)^(1/3), phys(data_1["P4_e"]["pol"]) * p_scale / (E1)^(1/3), label=L"E_{z=0}=1e-09", color=:red)
	lines!(ax4_3, (data_2["P4_e"]["r"] .- P4[1]) / (E2)^(1/3), phys(data_2["P4_e"]["pol"]) * p_scale / (E2)^(1/3), label=L"E_{z=0}=1e-08", color=:green)
	Label(fig4_1[1,3, Top()], halign=:left, L"\times 10^{-4}")
	save("fig/cuts/p4-l.svg",fig4_1)
	fig4_1
end

# ╔═╡ 0bf2cd74-40ac-43e3-81d5-f697bdaf1b5e
@bind p4_scale_r1 PlutoUI.Slider(-1:0.01:1, default=1/3, show_value=true)

# ╔═╡ 1315e480-f1a4-4fad-8f89-9dc0e825f675
@bind p4_scale_f1 PlutoUI.Slider(-1:0.01:1, default=0, show_value=true)

# ╔═╡ 1bcccc7d-10ae-4e6f-b936-546a3fd8a953
md"""
# P4 in the bulk
The scaling of the $P_4$ of velocity $v_{\phi}$ at local is a1 = $p4_scale_r1 and b1 = $p4_scale_f1

For the velocity $v_{\rho}$ and $v_{\theta}$ is same
"""

# ╔═╡ b3515466-20ea-4dde-be7f-d74470b94074
begin
	fig4_1_1 = Figure(size=(1500, 400), theme=publication_theme())
    ax4_1_1 = Axis(fig4_1_1[1, 1], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\phi}", title=L"$P_{4} -\text{in the bulk}$")
	lines!(ax4_1_1, (data_0["P4_b"]["r"] .- P4[1]) / (E0)^(p4_scale_r1), phys(data_0["P4_b"]["azi"]) * p_scale / (E0)^(p4_scale_f1), label=L"E_{z=0.4}=1e-10", color=:blue)
	lines!(ax4_1_1, (data_1["P4_b"]["r"] .- P4[1]) / (E1)^(p4_scale_r1), phys(data_1["P4_b"]["azi"]) * p_scale / (E1)^(p4_scale_f1), label=L"E_{z=0.4}=1e-09", color=:red)
	lines!(ax4_1_1, (data_2["P4_b"]["r"] .- P4[1]) / (E2)^(p4_scale_r1), phys(data_2["P4_b"]["azi"]) * p_scale / (E2)^(p4_scale_f1), label=L"E_{z=0.4}=1e-08", color=:green)
	axislegend(ax4_1_1, position=:rb)
	Label(fig4_1_1[1,1, Top()], halign=:left, L"\times 10^{-4}")
	
	ax4_1_2 = Axis(fig4_1_1[1, 2], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\rho}", title=L"$P_{4} -\text{in the bulk}$")
	lines!(ax4_1_2, (data_0["P4_b"]["r"] .- P4[1]) / (E0)^(p4_scale_r1), phys(data_0["P4_b"]["rad"]) * p_scale / (E0)^(p4_scale_f1), label=L"E_{z=0.4}=1e-10", color=:blue)
	lines!(ax4_1_2, (data_1["P4_b"]["r"] .- P4[1]) / (E1)^(p4_scale_r1), phys(data_1["P4_b"]["rad"]) * p_scale / (E1)^(p4_scale_f1), label=L"E_{z=0.4}=1e-09", color=:red)
	lines!(ax4_1_2, (data_2["P4_b"]["r"] .- P4[1]) / (E2)^(p4_scale_r1), phys(data_2["P4_b"]["rad"]) * p_scale / (E2)^(p4_scale_f1), label=L"E_{z=0.4}=1e-08", color=:green)
	Label(fig4_1_1[1,2, Top()], halign=:left, L"\times 10^{-4}")
	
	
	ax4_1_3 = Axis(fig4_1_1[1, 3], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\theta}", title=L"$P_{4} -\text{in the bulk}$")
	lines!(ax4_1_3, (data_0["P4_b"]["r"] .- P4[1]) / (E0)^(p4_scale_r1), phys(data_0["P4_b"]["pol"]) * p_scale / (E0)^(p4_scale_f1), label=L"E_{z=0}=1e-10", color=:blue)
	lines!(ax4_1_3, (data_1["P4_b"]["r"] .- P4[1]) / (E1)^(p4_scale_r1), phys(data_1["P4_b"]["pol"]) * p_scale / (E1)^(p4_scale_f1), label=L"E_{z=0}=1e-09", color=:red)
	lines!(ax4_1_3, (data_2["P4_b"]["r"] .- P4[1]) / (E2)^(p4_scale_r1), phys(data_2["P4_b"]["pol"]) * p_scale / (E2)^(p4_scale_f1), label=L"E_{z=0}=1e-08", color=:green)
	Label(fig4_1_1[1,3, Top()], halign=:left, L"\times 10^{-4}")
	save("fig/cuts/p4-b.svg",fig4_1_1)
	fig4_1_1
end

# ╔═╡ 87623811-d0e4-4ed4-9de6-97896da95b0b
md"""
# P4 local with r dir
The scaling is 1/3 and -1/6

and -11/50
"""

# ╔═╡ 10edb68b-32f5-40f7-b77a-d9436d9fde95
@bind p4_scale_lr PlutoUI.Slider(-1:0.01:1, default=1/3, show_value=true)

# ╔═╡ 8c51121b-e12f-4a6d-bd3f-6396d9c5fef8
@bind p4_scale_flr PlutoUI.Slider(-1:0.01:1, default=-1/6, show_value=true)

# ╔═╡ 9d3f15e4-8cad-4926-b33f-8fc0b27290e1
begin
	fig10a_1 = Figure(size=(1500, 400), theme=publication_theme())
    axa10_1 = Axis(fig10a_1[1, 1], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\phi}", title=L"$P_{4} -\text{local r dir}$")
	lines!(axa10_1, (data_0["P4_lr"]["r"] .- P4[1]) / (E0)^(p4_scale_lr), phys(data_0["P4_lr"]["azi"]) * p_scale / (E0)^(p4_scale_flr), label=L"E_{z=0.4}=1e-10", color=:blue)
	lines!(axa10_1, (data_1["P4_lr"]["r"] .- P4[1]) / (E1)^(p4_scale_lr), phys(data_1["P4_lr"]["azi"]) * p_scale / (E1)^(p4_scale_flr), label=L"E_{z=0.4}=1e-09", color=:red)
	lines!(axa10_1, (data_2["P4_lr"]["r"] .- P4[1]) / (E2)^(p4_scale_lr), phys(data_2["P4_lr"]["azi"]) * p_scale / (E2)^(p4_scale_flr), label=L"E_{z=0.4}=1e-08", color=:green)
	axislegend(axa10_1, position=:lt)
	Label(fig10a_1[1,1, Top()], halign=:left, L"\times 10^{-4}")
	xlims!(-20,0)
	
	axa10_2 = Axis(fig10a_1[1, 2], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\rho}", title=L"$P_{4} -\text{local r dir}$")
	lines!(axa10_2, (data_0["P4_lr"]["r"] .- P4[1]) / (E0)^(p4_scale_lr), phys(data_0["P4_lr"]["rad"]) * p_scale / (E0)^(-1/6), label=L"E_{z=0.4}=1e-10", color=:blue)
	lines!(axa10_2, (data_1["P4_lr"]["r"] .- P4[1]) / (E1)^(p4_scale_lr), phys(data_1["P4_lr"]["rad"]) * p_scale / (E1)^(-1/6), label=L"E_{z=0.4}=1e-09", color=:red)
	lines!(axa10_2, (data_2["P4_lr"]["r"] .- P4[1]) / (E2)^(p4_scale_lr), phys(data_2["P4_lr"]["rad"]) * p_scale / (E2)^(-1/6), label=L"E_{z=0.4}=1e-08", color=:green)
	Label(fig10a_1[1,2, Top()], halign=:left, L"\times 10^{-4}")
	
	
	
	axa10_3 = Axis(fig10a_1[1, 3], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\theta}", title=L"$P_{4} -\text{local r dir}$")
	lines!(axa10_3, (data_0["P4_lr"]["r"] .- P4[1]) / (E0)^(p4_scale_lr), phys(data_0["P4_lr"]["pol"]) * p_scale / (E0)^(-1/6), label=L"E_{z=0}=1e-10", color=:blue)
	lines!(axa10_3, (data_1["P4_lr"]["r"] .- P4[1]) / (E1)^(p4_scale_lr), phys(data_1["P4_lr"]["pol"]) * p_scale / (E1)^(-1/6), label=L"E_{z=0}=1e-09", color=:red)
	lines!(axa10_3, (data_2["P4_lr"]["r"] .- P4[1]) / (E2)^(p4_scale_lr), phys(data_2["P4_lr"]["pol"]) * p_scale / (E2)^(-1/6), label=L"E_{z=0}=1e-08", color=:green)
	Label(fig10a_1[1,3, Top()], halign=:left, L"\times 10^{-4}")

	save("fig/cuts/p4-lr.svg",fig10a_1)
	fig10a_1
end

# ╔═╡ cbf7021c-9f0d-4c40-ba61-bd11683ad4bd
md"""
# P4 local with z dir
The scaling is 1/3 and -1/6

and -11/50
"""

# ╔═╡ 83632874-69d5-45a3-9cea-77b9f3c6640f
@bind p4_scale_lz PlutoUI.Slider(-1:0.01:1, default=1/3, show_value=true)

# ╔═╡ 16d1b914-0316-468e-b203-2548e6d4b5b7
@bind p4_scale_flz PlutoUI.Slider(-1:0.01:1, default=-1/6, show_value=true)

# ╔═╡ 1a899f9e-1ad9-462f-8928-80a6c06dcbd2
begin
	fig10b_1 = Figure(size=(1500, 400), theme=publication_theme())
    axb10_1 = Axis(fig10b_1[1, 1], xlabel=L"\tilde{z}", ylabel=L"\tilde{v}_{\phi}", title=L"$P_{4} -\text{local z dir}$")
	lines!(axb10_1, (data_0["P4_lz"]["z"] .- P4[2]) / (E0)^(p4_scale_lz), phys(data_0["P4_lr"]["azi"]) * p_scale / (E0)^(p4_scale_flz), label=L"E_{z=0.4}=1e-10", color=:blue)
	lines!(axb10_1, (data_1["P4_lz"]["z"] .- P4[2]) / (E1)^(p4_scale_lz), phys(data_1["P4_lr"]["azi"]) * p_scale / (E1)^(p4_scale_flz), label=L"E_{z=0.4}=1e-09", color=:red)
	lines!(axb10_1, (data_2["P4_lz"]["z"] .- P4[2]) / (E2)^(p4_scale_lz), phys(data_2["P4_lr"]["azi"]) * p_scale / (E2)^(p4_scale_flz), label=L"E_{z=0.4}=1e-08", color=:green)
	axislegend(axb10_1, position=:lt)
	Label(fig10b_1[1,1, Top()], halign=:left, L"\times 10^{-4}")
	xlims!(-20,0)
	
	axb10_2 = Axis(fig10b_1[1, 2], xlabel=L"\tilde{z}", ylabel=L"\tilde{v}_{\rho}", title=L"$P_{4} -\text{local z dir}$")
	lines!(axb10_2, (data_0["P4_lz"]["z"] .- P4[2]) / (E0)^(p4_scale_lz), phys(data_0["P4_lr"]["rad"]) * p_scale / (E0)^(-1/6), label=L"E_{z=0.4}=1e-10", color=:blue)
	lines!(axb10_2, (data_1["P4_lz"]["z"] .- P4[2]) / (E1)^(p4_scale_lz), phys(data_1["P4_lr"]["rad"]) * p_scale / (E1)^(-1/6), label=L"E_{z=0.4}=1e-09", color=:red)
	lines!(axb10_2, (data_2["P4_lz"]["z"] .- P4[2]) / (E2)^(p4_scale_lz), phys(data_2["P4_lr"]["rad"]) * p_scale / (E2)^(-1/6), label=L"E_{z=0.4}=1e-08", color=:green)
	Label(fig10b_1[1,2, Top()], halign=:left, L"\times 10^{-4}")
	
	
	
	axb10_3 = Axis(fig10b_1[1, 3], xlabel=L"\tilde{z}", ylabel=L"\tilde{v}_{\theta}", title=L"$P_{4} -\text{local z dir}$")
	lines!(axb10_3, (data_0["P4_lz"]["z"] .- P4[2]) / (E0)^(p4_scale_lz), phys(data_0["P4_lr"]["pol"]) * p_scale / (E0)^(-1/6), label=L"E_{z=0}=1e-10", color=:blue)
	lines!(axb10_3, (data_1["P4_lz"]["z"] .- P4[2]) / (E1)^(p4_scale_lz), phys(data_1["P4_lr"]["pol"]) * p_scale / (E1)^(-1/6), label=L"E_{z=0}=1e-09", color=:red)
	lines!(axb10_3, (data_2["P4_lz"]["z"] .- P4[2]) / (E2)^(p4_scale_lz), phys(data_2["P4_lr"]["pol"]) * p_scale / (E2)^(-1/6), label=L"E_{z=0}=1e-08", color=:green)
	Label(fig10b_1[1,3, Top()], halign=:left, L"\times 10^{-4}")

	save("fig/cuts/p4-lz.svg",fig10b_1)
	fig10b_1
end

# ╔═╡ 518add50-9b57-4cfb-8b15-5f37ab5dca06
@bind p5_scale_r PlutoUI.Slider(-1:0.01:1, default=1/3, show_value=true)

# ╔═╡ 62d4f100-9520-468f-adeb-568cec8d839f
@bind p5_scale_f PlutoUI.Slider(-1:0.01:1, default=-1/6, show_value=true)

# ╔═╡ 5fa32836-46f3-492d-8e9d-541a6f01603d
begin
	fig5 = Figure(size=(1500, 400), theme=publication_theme())
    ax5_1 = Axis(fig5[1, 1], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\phi}", title=L"$P_{5} -\text{at the equator}$")
	lines!(ax5_1, (data_0["P5_l"]["r"] .- P5[1]) / (E0)^(p5_scale_r), phys(data_0["P5_l"]["azi"]) * p_scale / (E0)^(p5_scale_f), label=L"E_{z=0}=1e-10", color=:blue)
	lines!(ax5_1, (data_1["P5_l"]["r"] .- P5[1]) / (E1)^(p5_scale_r), phys(data_1["P5_l"]["azi"]) * p_scale / (E1)^(p5_scale_f), label=L"E_{z=0}=1e-09", color=:red)
	lines!(ax5_1, (data_2["P5_l"]["r"] .- P5[1]) / (E2)^(p5_scale_r), phys(data_2["P5_l"]["azi"]) * p_scale / (E2)^(p5_scale_f), label=L"E_{z=0}=1e-08", color=:green)
	axislegend(ax5_1, position=:rb)
	Label(fig5[1,1, Top()], halign=:left, L"\times 10^{-4}")
	
	ax5_2 = Axis(fig5[1, 2], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\rho}", title=L"$P_{5} -\text{at the equator}$")
	lines!(ax5_2, (data_0["P5_l"]["r"] .- P5[1]) / (E0)^(p5_scale_r), phys(data_0["P5_l"]["rad"]) * p_scale / (E0)^(p5_scale_f), label=L"E_{z=0}=1e-10", color=:blue)
	lines!(ax5_2, (data_1["P5_l"]["r"] .- P5[1]) / (E1)^(p5_scale_r), phys(data_1["P5_l"]["rad"]) * p_scale / (E1)^(p5_scale_f), label=L"E_{z=0}=1e-09", color=:red)
	lines!(ax5_2, (data_2["P5_l"]["r"] .- P5[1]) / (E2)^(p5_scale_r), phys(data_2["P5_l"]["rad"]) * p_scale / (E2)^(p5_scale_f), label=L"E_{z=0}=1e-08", color=:green)
	Label(fig5[1,2, Top()], halign=:left, L"\times 10^{-4}")
	
	ax5_3 = Axis(fig5[1, 3], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\theta}", title=L"$P_{5} -\text{at the equator}$")
	lines!(ax5_3, (data_0["P5_l"]["r"] .- P5[1]) / (E0)^(p5_scale_r), phys(data_0["P5_l"]["pol"]) * p_scale / (E0)^(p5_scale_f), label=L"E_{z=0}=1e-10", color=:blue)
	lines!(ax5_3, (data_1["P5_l"]["r"] .- P5[1]) / (E1)^(p5_scale_r), phys(data_1["P5_l"]["pol"]) * p_scale / (E1)^(p5_scale_f), label=L"E_{z=0}=1e-09", color=:red)
	lines!(ax5_3, (data_2["P5_l"]["r"] .- P5[1]) / (E2)^(p5_scale_r), phys(data_2["P5_l"]["pol"]) * p_scale / (E2)^(p5_scale_f), label=L"E_{z=0}=1e-08", color=:green)
	Label(fig5[1,3, Top()], halign=:left, L"\times 10^{-4}")
	save("fig/cuts/p5-e.svg",fig5)
	fig5
end

# ╔═╡ 3633c707-42eb-4952-afc6-0945ec586b05
@bind p5_scale_r1 PlutoUI.Slider(-1:0.01:1, default=1/3, show_value=true)

# ╔═╡ a9d8b759-77ed-4aab-a536-64eb00becdb1
@bind p5_scale_f1 PlutoUI.Slider(-1:0.01:1, default=1/6, show_value=true)

# ╔═╡ 6c110f7e-e578-45f5-a6a9-c9c376177266
md"""
# P5 at equator (local)
The scaling of the $P_5$ of velocity $v_{\phi}$ at local is a1 = $p5_scale_r1 and b1 = $p5_scale_f1

For the velocity $v_{\rho}$ is same and $v_{\theta}$ is small
"""

# ╔═╡ 10155243-43ef-4fc8-8d08-71aa7d13deea
md"""
# P5 in the bulk
The scaling of the $P_5$ of velocity $v_{\phi}$ at local is a1 = $p5_scale_r1 and b1 = $p5_scale_f1

For the velocity $v_{\rho}$ is same and $v_{\theta}$ is small
"""

# ╔═╡ 545ec3ef-a912-457c-acb8-faf2f43c946b
begin
	fig5_1 = Figure(size=(1500, 400), theme=publication_theme())
    ax5_1_1 = Axis(fig5_1[1, 1], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\phi}", title=L"$P_{5} -\text{in the bulk}$")
	lines!(ax5_1_1, (data_0["P5_b"]["r"] .- P5[1]) / (E0)^(p5_scale_r1), phys(data_0["P5_b"]["azi"]) * p_scale / (E0)^(p5_scale_f1), label=L"E_{z=0.4}=1e-10", color=:blue)
	lines!(ax5_1_1, (data_1["P5_b"]["r"] .- P5[1]) / (E1)^(p5_scale_r1), phys(data_1["P5_b"]["azi"]) * p_scale / (E1)^(p5_scale_f1), label=L"E_{z=0.4}=1e-09", color=:red)
	lines!(ax5_1_1, (data_2["P5_b"]["r"] .- P5[1]) / (E2)^(p5_scale_r1), phys(data_2["P5_b"]["azi"]) * p_scale / (E2)^(p5_scale_f1), label=L"E_{z=0.4}=1e-08", color=:green)
	axislegend(ax5_1_1, position=:rt)
	Label(fig5_1[1,1, Top()], halign=:left, L"\times 10^{-4}")
	
	ax5_1_2 = Axis(fig5_1[1, 2], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\rho}", title=L"$P_{5} -\text{in the bulk}$")
	# lines!(ax5_1_2, (data_0["P5_b"]["r"] .- P5[1]) / (E0)^(p5_scale_r1), phys(data_0["P5_b"]["rad"]) * p_scale / (E0)^(p5_scale_f1), label=L"E_{z=0.4}=1e-10", color=:blue)
	lines!(ax5_1_2, (data_1["P5_b"]["r"] .- P5[1]) / (E1)^(p5_scale_r1), phys(data_1["P5_b"]["rad"]) * p_scale / (E1)^(p5_scale_f1), label=L"E_{z=0.4}=1e-09", color=:red)
	lines!(ax5_1_2, (data_2["P5_b"]["r"] .- P5[1]) / (E2)^(p5_scale_r1), phys(data_2["P5_b"]["rad"]) * p_scale / (E2)^(p5_scale_f1), label=L"E_{z=0.4}=1e-08", color=:green)
	Label(fig5_1[1,2, Top()], halign=:left, L"\times 10^{-4}")
	
	ax5_1_3 = Axis(fig5_1[1, 3], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\theta}", title=L"$P_{5} -\text{in the bulk}$")
	# lines!(ax5_1_3, (data_0["P5_b"]["r"] .- P5[1]) / (E0)^(p5_scale_r1), phys(data_0["P5_b"]["pol"]) * p_scale / (E0)^(p5_scale_f1), label=L"E_{z=0.4}=1e-10", color=:blue)
	lines!(ax5_1_3, (data_1["P5_b"]["r"] .- P5[1]) / (E1)^(p5_scale_r1), phys(data_1["P5_b"]["pol"]) * p_scale / (E1)^(p5_scale_f1), label=L"E_{z=0.4}=1e-09", color=:red)
	lines!(ax5_1_3, (data_2["P5_b"]["r"] .- P5[1]) / (E2)^(p5_scale_r1), phys(data_2["P5_b"]["pol"]) * p_scale / (E2)^(p5_scale_f1), label=L"E_{z=0.4}=1e-08", color=:green)
	Label(fig5_1[1,3, Top()], halign=:left, L"\times 10^{-4}")
	save("fig/cuts/p5-b.svg",fig5_1)
	fig5_1
end

# ╔═╡ 5dccc083-6c6e-460c-ad88-5319f65c65c2
@bind p7_scale_r PlutoUI.Slider(-1:0.01:1, default=1/4, show_value=true)

# ╔═╡ 5b13bfd2-c12e-4ecd-857e-46dd6b3e9a7a
@bind p7_scale_f PlutoUI.Slider(-1:0.01:1, default=-1/7, show_value=true)

# ╔═╡ e6afc495-9ea7-491c-b928-741d7b9fd539
md"""
# P7 in the bulk
The scaling of the $P_7$ of velocity $v_{\phi}$ in the bulk is a1 = $p7_scale_r and b1 = $p7_scale_f

For the velocity $v_{\rho}$ is a2 = 1/3, b2 = 0 and $v_{\theta}$ is small
"""

# ╔═╡ 272d64a2-f7df-436c-8b01-908eab60ab4e
begin
	fig7 = Figure(size=(1500, 400), theme=publication_theme())
    ax7_1 = Axis(fig7[1, 1], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\phi}", title=L"$P_{7} -\text{in the bulk}$")
	lines!(ax7_1, (data_0["P7_b"]["r"] .- P7[1]) / (E0)^(p7_scale_r), phys(data_0["P7_b"]["azi"]) * p_scale / (E0)^(p7_scale_f), label=L"E_{z=0.2}=1e-10", color=:blue)
	lines!(ax7_1, (data_1["P7_b"]["r"] .- P7[1]) / (E1)^(p7_scale_r), phys(data_1["P7_b"]["azi"]) * p_scale / (E1)^(p7_scale_f), label=L"E_{z=0.2}=1e-09", color=:red)
	lines!(ax7_1, (data_2["P7_b"]["r"] .- P7[1]) / (E2)^(p7_scale_r), phys(data_2["P7_b"]["azi"]) * p_scale / (E2)^(p7_scale_f), label=L"E_{z=0.2}=1e-08", color=:green)
	axislegend(ax7_1, position=:rt)
	Label(fig7[1,1, Top()], halign=:left, L"\times 10^{-4}")
	
	ax7_2 = Axis(fig7[1, 2], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\rho}", title=L"$P_{7} -\text{in the bulk}$")
	lines!(ax7_2, (data_0["P7_b"]["r"] .- P7[1]) / (E0)^(1/3), phys(data_0["P7_b"]["rad"]) * p_scale / (E0)^(0), label=L"E_{z=0.2}=1e-10", color=:blue)
	lines!(ax7_2, (data_1["P7_b"]["r"] .- P7[1]) / (E1)^(1/3), phys(data_1["P7_b"]["rad"]) * p_scale / (E1)^(0), label=L"E_{z=0.2}=1e-09", color=:red)
	lines!(ax7_2, (data_2["P7_b"]["r"] .- P7[1]) / (E2)^(1/3), phys(data_2["P7_b"]["rad"]) * p_scale / (E2)^(0), label=L"E_{z=0.2}=1e-08", color=:green)
	Label(fig7[1,2, Top()], halign=:left, L"\times 10^{-4}")
	
	ax7_3 = Axis(fig7[1, 3], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\theta}", title=L"$P_{7} -\text{in the bulk}$")
	lines!(ax7_3, (data_0["P7_b"]["r"] .- P7[1]) / (E0)^(1/3), phys(data_0["P7_b"]["pol"]) * p_scale / (E0)^(0), label=L"E_{z=0.2}=1e-10", color=:blue)
	lines!(ax7_3, (data_1["P7_b"]["r"] .- P7[1]) / (E1)^(1/3), phys(data_1["P7_b"]["pol"]) * p_scale / (E1)^(0), label=L"E_{z=0.2}=1e-09", color=:red)
	lines!(ax7_3, (data_2["P7_b"]["r"] .- P7[1]) / (E2)^(1/3), phys(data_2["P7_b"]["pol"]) * p_scale / (E2)^(0), label=L"E_{z=0.2}=1e-08", color=:green)
	Label(fig7[1,3, Top()], halign=:left, L"\times 10^{-4}")
	save("fig/cuts/p7-b.svg",fig7)
	fig7
end

# ╔═╡ 5766b3b4-a596-4c49-8000-e1e174542193
@bind p7_scale_r1 PlutoUI.Slider(-1:0.01:1, default=1/4, show_value=true)

# ╔═╡ ba751a1a-2807-430c-b8c3-8c02d08b1f69
@bind p7_scale_f1 PlutoUI.Slider(-1:0.01:1, default=-1/7, show_value=true)

# ╔═╡ fd5000d7-3494-4d29-a7db-ea744f92eeda
md"""
# P7 at the equator 
The scaling of the $P_7$ of velocity $v_{\phi}$ at the equator is a1 = $p7_scale_r1 and b1 = $p7_scale_f1

For the velocity $v_{\rho}$ is a2 = 1/3 , b2=1/3 and $v_{\theta}$ is small
"""

# ╔═╡ b9c54b0c-7547-439a-ace7-7c3831fae357
begin
	fig7_1 = Figure(size=(1500, 400), theme=publication_theme())
    ax7_1_1 = Axis(fig7_1[1, 1], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\phi}", title=L"$P_{7} -\text{on the equator}$")
	lines!(ax7_1_1, (data_0["P7_e"]["r"] .- P7[1]) / (E0)^(p7_scale_r1), phys(data_0["P7_e"]["azi"]) * p_scale / (E0)^(p7_scale_f1), label=L"E_{z=0}=1e-10", color=:blue)
	lines!(ax7_1_1, (data_1["P7_e"]["r"] .- P7[1]) / (E1)^(p7_scale_r1), phys(data_1["P7_e"]["azi"]) * p_scale / (E1)^(p7_scale_f1), label=L"E_{z=0}=1e-09", color=:red)
	lines!(ax7_1_1, (data_2["P7_e"]["r"] .- P7[1]) / (E2)^(p7_scale_r1), phys(data_2["P7_e"]["azi"]) * p_scale / (E2)^(p7_scale_f1), label=L"E_{z=0}=1e-08", color=:green)
	axislegend(ax7_1_1, position=:rt)
	Label(fig7_1[1,1, Top()], halign=:left, L"\times 10^{-4}")
	
	ax7_1_2 = Axis(fig7_1[1, 2], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\rho}", title=L"$P_{7} -\text{on the equator}$")
	# lines!(ax7_1_2, (data_0["P7_e"]["r"] .- P7[1]) / (E0)^(1/3), phys(data_0["P7_e"]["rad"]) * p_scale / (E0)^(1/3), label=L"E_{z=0}=1e-10", color=:blue)
	lines!(ax7_1_2, (data_1["P7_e"]["r"] .- P7[1]) / (E1)^(1/3), phys(data_1["P7_e"]["rad"]) * p_scale / (E1)^(1/3), label=L"E_{z=0}=1e-09", color=:red)
	lines!(ax7_1_2, (data_2["P7_e"]["r"] .- P7[1]) / (E2)^(1/3), phys(data_2["P7_e"]["rad"]) * p_scale / (E2)^(1/3), label=L"E_{z=0}=1e-08", color=:green)
	Label(fig7_1[1,2, Top()], halign=:left, L"\times 10^{-4}")
	
	ax7_1_3 = Axis(fig7_1[1, 3], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\theta}", title=L"$P_{7} -\text{on the equator}$")
	# lines!(ax7_1_3, (data_0["P7_e"]["r"] .- P7[1]) / (E0)^(1/3), phys(data_0["P7_e"]["pol"]) * p_scale / (E0)^(1/3), label=L"E_{z=0}=1e-10", color=:blue)
	lines!(ax7_1_3, (data_1["P7_e"]["r"] .- P7[1]) / (E1)^(1/3), phys(data_1["P7_e"]["pol"]) * p_scale / (E1)^(1/3), label=L"E_{z=0}=1e-09", color=:red)
	lines!(ax7_1_3, (data_2["P7_e"]["r"] .- P7[1]) / (E2)^(1/3), phys(data_2["P7_e"]["pol"]) * p_scale / (E2)^(1/3), label=L"E_{z=0}=1e-08", color=:green)
	Label(fig7_1[1,3, Top()], halign=:left, L"\times 10^{-4}")
	save("fig/cuts/p7-e.svg",fig7_1)
	fig7_1
end

# ╔═╡ b94090a3-60d6-472d-b6fa-3466717188e5
md"""
# P7 local with r dir

The scaling is 1/3 and -1/6

and -11/50
"""

# ╔═╡ 96d98a40-dc2e-4dcc-ba22-fbfa55913077
@bind p7_scale_lr PlutoUI.Slider(-1:0.01:1, default=1/3, show_value=true)

# ╔═╡ f9e3b8c1-76f4-4387-85d1-be45b627dfcb
@bind p7_scale_flr PlutoUI.Slider(-1:0.01:1, default=-1/6, show_value=true)

# ╔═╡ 8cd6da1e-27ed-441a-8659-4b79e5ee9bae
begin
	fig20a_1 = Figure(size=(1500, 400), theme=publication_theme())
    axa20_1 = Axis(fig20a_1[1, 1], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\phi}", title=L"$P_{7} -\text{local r dir}$")
	lines!(axa20_1, (data_0["P7_lr"]["r"] .- P7[1]) / (E0)^(p7_scale_lr), phys(data_0["P7_lr"]["azi"]) * p_scale / (E0)^(p7_scale_flr), label=L"E_{z=0.4}=1e-10", color=:blue)
	lines!(axa20_1, (data_1["P7_lr"]["r"] .- P7[1]) / (E1)^(p7_scale_lr), phys(data_1["P7_lr"]["azi"]) * p_scale / (E1)^(p7_scale_flr), label=L"E_{z=0.4}=1e-09", color=:red)
	lines!(axa20_1, (data_2["P7_lr"]["r"] .- P7[1]) / (E2)^(p7_scale_lr), phys(data_2["P7_lr"]["azi"]) * p_scale / (E2)^(p7_scale_flr), label=L"E_{z=0.4}=1e-08", color=:green)
	axislegend(axa20_1, position=:lt)
	Label(fig20a_1[1,1, Top()], halign=:left, L"\times 10^{-4}")
	
	axa20_2 = Axis(fig20a_1[1, 2], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\rho}", title=L"$P_{7} -\text{local r dir}$")
	lines!(axa20_2, (data_0["P7_lr"]["r"] .- P7[1]) / (E0)^(p7_scale_lr), phys(data_0["P7_lr"]["rad"]) * p_scale / (E0)^(p7_scale_flr), label=L"E_{z=0.4}=1e-10", color=:blue)
	lines!(axa20_2, (data_1["P7_lr"]["r"] .- P7[1]) / (E1)^(p7_scale_lr), phys(data_1["P7_lr"]["rad"]) * p_scale / (E1)^(p7_scale_flr), label=L"E_{z=0.4}=1e-09", color=:red)
	lines!(axa20_2, (data_2["P7_lr"]["r"] .- P7[1]) / (E2)^(p7_scale_lr), phys(data_2["P7_lr"]["rad"]) * p_scale / (E2)^(p7_scale_flr), label=L"E_{z=0.4}=1e-08", color=:green)
	Label(fig20a_1[1,2, Top()], halign=:left, L"\times 10^{-4}")
	
	
	
	axa20_3 = Axis(fig20a_1[1, 3], xlabel=L"\tilde{r}", ylabel=L"\tilde{v}_{\theta}", title=L"$P_{7} -\text{local r dir}$")
	lines!(axa20_3, (data_0["P7_lr"]["r"] .- P7[1]) / (E0)^(p7_scale_lr), phys(data_0["P7_lr"]["pol"]) * p_scale / (E0)^(p7_scale_flr), label=L"E_{z=0}=1e-10", color=:blue)
	lines!(axa20_3, (data_1["P7_lr"]["r"] .- P7[1]) / (E1)^(p7_scale_lr), phys(data_1["P7_lr"]["pol"]) * p_scale / (E1)^(p7_scale_flr), label=L"E_{z=0}=1e-09", color=:red)
	lines!(axa20_3, (data_2["P7_lr"]["r"] .- P7[1]) / (E2)^(p7_scale_lr), phys(data_2["P7_lr"]["pol"]) * p_scale / (E2)^(p7_scale_flr), label=L"E_{z=0}=1e-08", color=:green)
	Label(fig20a_1[1,3, Top()], halign=:left, L"\times 10^{-4}")

	save("fig/cuts/p7-lr.svg",fig20a_1)
	fig20a_1
end

# ╔═╡ 15ba337a-6718-4c27-b3f1-5905fb4e0ded
md"""
# P7 local with z dir
The scaling is 1/3 and -1/6

and -11/50
"""

# ╔═╡ ef547640-eaf8-4b1f-b0cb-a83964bb0ed8
@bind p7_scale_lz PlutoUI.Slider(-1:0.01:1, default=1/3, show_value=true)

# ╔═╡ 53bee696-3229-4fd2-937c-1c37d02fdc9e
@bind p7_scale_flz PlutoUI.Slider(-1:0.01:1, default=-1/6, show_value=true)

# ╔═╡ ee0c8aa9-fd23-4e16-bb83-affbaf97a9b8
begin
	fig20b_1 = Figure(size=(1500, 400), theme=publication_theme())
    axb20_1 = Axis(fig20b_1[1, 1], xlabel=L"\tilde{z}", ylabel=L"\tilde{v}_{\phi}", title=L"$P_{7} -\text{local z dir}$")
	lines!(axb20_1, (data_0["P7_lz"]["z"] .- P7[2]) / (E0)^(p7_scale_lz), phys(data_0["P7_lr"]["azi"]) * p_scale / (E0)^(p7_scale_flz), label=L"E_{z=0.4}=1e-10", color=:blue)
	lines!(axb20_1, (data_1["P7_lz"]["z"] .- P7[2]) / (E1)^(p7_scale_lz), phys(data_1["P7_lr"]["azi"]) * p_scale / (E1)^(p7_scale_flz), label=L"E_{z=0.4}=1e-09", color=:red)
	lines!(axb20_1, (data_2["P7_lz"]["z"] .- P7[2]) / (E2)^(p7_scale_lz), phys(data_2["P7_lr"]["azi"]) * p_scale / (E2)^(p7_scale_flz), label=L"E_{z=0.4}=1e-08", color=:green)
	axislegend(axb20_1, position=:lt)
	Label(fig20b_1[1,1, Top()], halign=:left, L"\times 10^{-4}")
	
	
	axb20_2 = Axis(fig20b_1[1, 2], xlabel=L"\tilde{z}", ylabel=L"\tilde{v}_{\rho}", title=L"$P_{7} -\text{local z dir}$")
	lines!(axb20_2, (data_0["P7_lz"]["z"] .- P7[2]) / (E0)^(p7_scale_lz), phys(data_0["P7_lr"]["rad"]) * p_scale / (E0)^(p7_scale_flz), label=L"E_{z=0.4}=1e-10", color=:blue)
	lines!(axb20_2, (data_1["P7_lz"]["z"] .- P7[2]) / (E1)^(p7_scale_lz), phys(data_1["P7_lr"]["rad"]) * p_scale / (E1)^(p7_scale_flz), label=L"E_{z=0.4}=1e-09", color=:red)
	lines!(axb20_2, (data_2["P7_lz"]["z"] .- P7[2]) / (E2)^(p7_scale_lz), phys(data_2["P7_lr"]["rad"]) * p_scale / (E2)^(p7_scale_flz), label=L"E_{z=0.4}=1e-08", color=:green)
	Label(fig20b_1[1,2, Top()], halign=:left, L"\times 10^{-4}")
	
	
	
	axb20_3 = Axis(fig20b_1[1, 3], xlabel=L"\tilde{z}", ylabel=L"\tilde{v}_{\theta}", title=L"$P_{7} -\text{local z dir}$")
	lines!(axb20_3, (data_0["P7_lz"]["z"] .- P7[2]) / (E0)^(p7_scale_lz), phys(data_0["P7_lr"]["pol"]) * p_scale / (E0)^(p7_scale_flz), label=L"E_{z=0}=1e-10", color=:blue)
	lines!(axb20_3, (data_1["P7_lz"]["z"] .- P7[2]) / (E1)^(p7_scale_lz), phys(data_1["P7_lr"]["pol"]) * p_scale / (E1)^(p7_scale_flz), label=L"E_{z=0}=1e-09", color=:red)
	lines!(axb20_3, (data_2["P7_lz"]["z"] .- P7[2]) / (E2)^(p7_scale_lz), phys(data_2["P7_lr"]["pol"]) * p_scale / (E2)^(p7_scale_flz), label=L"E_{z=0}=1e-08", color=:green)
	Label(fig20b_1[1,3, Top()], halign=:left, L"\times 10^{-4}")

	save("fig/cuts/p7-lz.svg",fig20b_1)
	fig20b_1
end

# ╔═╡ 21104deb-9952-4a91-80f6-3b8d1e9ef689
md"""
# Bulk between two spherical shells

"""

# ╔═╡ cd613973-2ffd-44ff-bea7-1e0120ff9335
@bind bulk_scale_r PlutoUI.Slider(-1:0.01:1, default=0, show_value=true)

# ╔═╡ b743707b-795a-462a-9e1a-5b13deeaa9fd
@bind bulk_scale_f PlutoUI.Slider(-1:0.01:1, default=-1/10, show_value=true)

# ╔═╡ 9dba894c-7f0d-4f50-8e85-39424551e9d8
begin
	f1 = Figure(size=(1500, 400), theme=publication_theme())
    a1_1 = Axis(f1[1, 1], xlabel=L"\tilde{z}", ylabel=L"\tilde{v}_{\phi}", title=L"$P_{7} -\text{local z dir}$")
	lines!(a1_1, (data_0["bulk_b"]["r"]) / (E0)^(bulk_scale_r), phys(data_0["bulk_b"]["azi"]) * p_scale / (E0)^(bulk_scale_f), label=L"E_{z=0.4}=1e-10", color=:blue)
	lines!(a1_1, (data_1["bulk_b"]["r"]) / (E1)^(bulk_scale_r), phys(data_1["bulk_b"]["azi"]) * p_scale / (E1)^(bulk_scale_f), label=L"E_{z=0.4}=1e-09", color=:red)
	lines!(a1_1, (data_2["bulk_b"]["r"]) / (E2)^(bulk_scale_r), phys(data_2["bulk_b"]["azi"]) * p_scale / (E2)^(bulk_scale_f), label=L"E_{z=0.4}=1e-08", color=:green)
	axislegend(a1_1, position=:lt)
	Label(f1[1,1, Top()], halign=:left, L"\times 10^{-4}")
	
	
	a1_2 = Axis(f1[1, 2], xlabel=L"\tilde{z}", ylabel=L"\tilde{v}_{\rho}", title=L"$P_{7} -\text{local z dir}$")
	lines!(a1_2, (data_0["bulk_b"]["r"]) / (E0)^(bulk_scale_r), phys(data_0["bulk_b"]["rad"]) * p_scale / (E0)^(bulk_scale_f), label=L"E_{z=0.4}=1e-10", color=:blue)
	lines!(a1_2, (data_1["bulk_b"]["r"]) / (E1)^(bulk_scale_r), phys(data_1["bulk_b"]["rad"]) * p_scale / (E1)^(bulk_scale_f), label=L"E_{z=0.4}=1e-09", color=:red)
	lines!(a1_2, (data_2["bulk_b"]["r"]) / (E2)^(bulk_scale_r), phys(data_2["bulk_b"]["rad"]) * p_scale / (E2)^(bulk_scale_f), label=L"E_{z=0.4}=1e-08", color=:green)
	Label(f1[1,2, Top()], halign=:left, L"\times 10^{-4}")
	
	
	
	a1_3 = Axis(f1[1, 3], xlabel=L"\tilde{z}", ylabel=L"\tilde{v}_{\theta}", title=L"$P_{7} -\text{local z dir}$")
	lines!(a1_3, (data_0["bulk_b"]["r"]) / (E0)^(bulk_scale_r), phys(data_0["bulk_b"]["pol"]) * p_scale / (E0)^(bulk_scale_f), label=L"E_{z=0}=1e-10", color=:blue)
	lines!(a1_3, (data_1["bulk_b"]["r"]) / (E1)^(bulk_scale_r), phys(data_1["bulk_b"]["pol"]) * p_scale / (E1)^(bulk_scale_f), label=L"E_{z=0}=1e-09", color=:red)
	lines!(a1_3, (data_2["bulk_b"]["r"]) / (E2)^(bulk_scale_r), phys(data_2["bulk_b"]["pol"]) * p_scale / (E2)^(bulk_scale_f), label=L"E_{z=0}=1e-08", color=:green)
	Label(f1[1,3, Top()], halign=:left, L"\times 10^{-4}")

	save("fig/cuts/bulk-b.svg",f1)
	f1
end

# ╔═╡ Cell order:
# ╠═76233465-1687-4bd9-a5c2-590631451dbe
# ╠═0937c2c8-e3e7-4550-a98f-11db608f29a3
# ╟─af9838f4-6128-404d-8032-c234d2f621aa
# ╟─55a57810-d590-4450-ae6a-1acc01b00570
# ╟─2c2c6978-5a6f-4a3a-a44f-dde95ec81345
# ╠═9b94cfd3-944e-4a58-af21-72adfac6e566
# ╟─ead3c674-5ba5-4c06-bd77-7b6dbba2feb2
# ╟─f077a76f-e628-4288-a780-0e3c00171e55
# ╠═6d785b45-2a50-4494-a0f8-a6ea44f84a0d
# ╠═f80b1310-6a0c-4369-a75c-0b30625f9fa2
# ╠═6e1f4d6f-86de-44ac-b87e-a386883d6a5a
# ╠═bb37e212-cec0-478a-869e-719514ffcc8c
# ╠═062ea521-983c-4141-b983-8dc93a582199
# ╠═0f178f26-8644-4d8a-99fb-30f3c70dbbed
# ╟─6b2e954d-34fc-42c8-83b3-177698d139f3
# ╠═95117c50-ecea-4268-9b79-a48fbf40390e
# ╠═73db3b57-b913-40cd-a8f3-9a5b41b8c2e5
# ╟─99092104-3e95-446b-ba4c-83e53471fb0d
# ╟─b2f9c586-942a-4801-ba88-35e359834fad
# ╠═6664f029-9279-4016-b8db-568f556fc23e
# ╠═de940f56-875c-4564-b23f-60b6b79fd3ae
# ╟─957bd58f-5a65-4597-89fa-d96ad8661059
# ╟─ee17b65f-e5d6-4fce-bce7-395b6c5f4aa8
# ╠═a10dc5fc-5416-448e-b360-b1d6518d69c0
# ╠═2ad49a94-8a47-4df9-be17-b8840cf5d843
# ╟─90f6ccb0-52a4-41b3-8337-17b7f4fcc694
# ╟─ddf67200-ec8c-44f4-a39d-033e301e59dc
# ╟─0d938568-3fa3-41e4-9df5-c0526912fc85
# ╠═620b8d2c-d244-4fe7-94dc-9ebd9ce5862a
# ╠═d0ddfb3b-1a2c-4bcb-876b-e5eeae97daac
# ╟─26685987-f5a7-4606-b46d-e57e42013000
# ╟─04b5bb63-6932-4e93-94b2-28e88d3bab10
# ╠═81c35893-e375-4240-b29a-b89ee99f7c3d
# ╠═4726485e-c5ac-49b0-9749-8039fdae6bba
# ╟─ac720d29-a226-4109-ac04-bea8b53b662f
# ╟─ac06f1fb-608e-4516-a8f2-d73978fd4617
# ╠═e9f37fbd-db1e-45b5-bc04-45acf580a322
# ╠═44f4d3d4-e508-453f-b056-ead68f0f3127
# ╟─216989ea-3716-4f8c-b706-2cad9f86c096
# ╟─5f0493d0-82fe-4881-85cc-f44a067e3a44
# ╠═e245323f-ea7a-499f-9702-64a7f26b55b8
# ╠═f26438a3-1a40-4084-945d-103ed7442630
# ╟─f569601e-60d8-4214-b1a0-9c50787537c2
# ╟─6468b992-018d-47ec-8a7b-4b91af2ecc23
# ╠═6145aa89-2522-404d-a1bd-846fb9ed76bf
# ╠═f121447e-c036-4a37-b7a5-3b9a82846c8f
# ╟─191ede80-1b4f-4c37-abb5-dbcea42d9386
# ╟─a6337d25-02d7-49e7-83dc-b73de7b37bca
# ╟─2db5578c-51de-49c3-9491-00e2357b4ae0
# ╠═776924cb-1ebc-4529-9f2c-41d9008375f5
# ╠═d669b223-d13c-4f97-b794-f0e97abe1645
# ╟─93d85478-2e5b-425e-8290-b9045dadb375
# ╟─1bcccc7d-10ae-4e6f-b936-546a3fd8a953
# ╠═0bf2cd74-40ac-43e3-81d5-f697bdaf1b5e
# ╠═1315e480-f1a4-4fad-8f89-9dc0e825f675
# ╟─b3515466-20ea-4dde-be7f-d74470b94074
# ╟─87623811-d0e4-4ed4-9de6-97896da95b0b
# ╠═10edb68b-32f5-40f7-b77a-d9436d9fde95
# ╠═8c51121b-e12f-4a6d-bd3f-6396d9c5fef8
# ╟─9d3f15e4-8cad-4926-b33f-8fc0b27290e1
# ╟─cbf7021c-9f0d-4c40-ba61-bd11683ad4bd
# ╠═83632874-69d5-45a3-9cea-77b9f3c6640f
# ╠═16d1b914-0316-468e-b203-2548e6d4b5b7
# ╟─1a899f9e-1ad9-462f-8928-80a6c06dcbd2
# ╟─6c110f7e-e578-45f5-a6a9-c9c376177266
# ╠═518add50-9b57-4cfb-8b15-5f37ab5dca06
# ╠═62d4f100-9520-468f-adeb-568cec8d839f
# ╟─5fa32836-46f3-492d-8e9d-541a6f01603d
# ╟─10155243-43ef-4fc8-8d08-71aa7d13deea
# ╠═3633c707-42eb-4952-afc6-0945ec586b05
# ╠═a9d8b759-77ed-4aab-a536-64eb00becdb1
# ╟─545ec3ef-a912-457c-acb8-faf2f43c946b
# ╟─e6afc495-9ea7-491c-b928-741d7b9fd539
# ╠═5dccc083-6c6e-460c-ad88-5319f65c65c2
# ╠═5b13bfd2-c12e-4ecd-857e-46dd6b3e9a7a
# ╟─272d64a2-f7df-436c-8b01-908eab60ab4e
# ╟─fd5000d7-3494-4d29-a7db-ea744f92eeda
# ╠═5766b3b4-a596-4c49-8000-e1e174542193
# ╠═ba751a1a-2807-430c-b8c3-8c02d08b1f69
# ╟─b9c54b0c-7547-439a-ace7-7c3831fae357
# ╟─b94090a3-60d6-472d-b6fa-3466717188e5
# ╠═96d98a40-dc2e-4dcc-ba22-fbfa55913077
# ╠═f9e3b8c1-76f4-4387-85d1-be45b627dfcb
# ╟─8cd6da1e-27ed-441a-8659-4b79e5ee9bae
# ╟─15ba337a-6718-4c27-b3f1-5905fb4e0ded
# ╠═ef547640-eaf8-4b1f-b0cb-a83964bb0ed8
# ╠═53bee696-3229-4fd2-937c-1c37d02fdc9e
# ╟─ee0c8aa9-fd23-4e16-bb83-affbaf97a9b8
# ╟─21104deb-9952-4a91-80f6-3b8d1e9ef689
# ╠═cd613973-2ffd-44ff-bea7-1e0120ff9335
# ╠═b743707b-795a-462a-9e1a-5b13deeaa9fd
# ╟─9dba894c-7f0d-4f50-8e85-39424551e9d8
