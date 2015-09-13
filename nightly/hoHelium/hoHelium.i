Simulations:
  - name: sim1
    time_integrator: ti_1
    optimizer: opt1

linear_solvers:

  - name: solve_adv_diff
    type: tpetra
    method: gmres
    preconditioner: sgs
    tolerance: 1e-5
    max_iterations: 50
    kspace: 50
    output_level: 0

  - name: solve_cont
    type: tpetra
    method: gmres
    preconditioner: muelu
    tolerance: 1e-5
    max_iterations: 75
    kspace: 75
    output_level: 0
    recompute_preconditioner: false

realms:

  - name: realm_1
    mesh:  1m_13K_P2_mks_s.g
    use_edges: no 

    equation_systems:
      name: theEqSys
      max_iterations: 4

      solver_system_specification:
        velocity: solve_adv_diff
        mixture_fraction: solve_adv_diff
        pressure: solve_cont
        dpdx: solve_adv_diff

      systems:
        - LowMachEOM:
            name: myLowMach
            max_iterations: 1
            convergence_tolerance: 1e-2
            manage_png: yes

        - MixtureFraction:
            name: myZ
            max_iterations: 1
            convergence_tolerance: 1.e-2

    initial_conditions:
      - constant: ic_1
        target_name: block_1
        value:
          pressure: 0
          velocity: [0,0]
          mixture_fraction: 0.0

    material_properties:
      target_name: block_1

      specifications:

        - name: density
          type: mixture_fraction
          primary_value: 0.163
          secondary_value: 1.18

        - name: viscosity
          type: mixture_fraction
          primary_value: 1.967e-5
          secondary_value: 1.85e-5

    boundary_conditions:

    - inflow_boundary_condition: bc_inflow
      target_name: surface_1
      inflow_user_data:
        velocity: [0.0,0.340,0.0]
        mixture_fraction: 1.0

    - wall_boundary_condition: bc_bottom
      target_name: surface_2
      wall_user_data:
        velocity: [0,0,0]
        
    - open_boundary_condition: bc_side
      target_name: surface_3
      open_user_data:
        velocity: [0,0,0]
        pressure: 0.0
        mixture_fraction: 0.0

    - open_boundary_condition: bc_top
      target_name: surface_4
      open_user_data:
        velocity: [0,0,0]
        pressure: 0.0
        mixture_fraction: 0.0

    solution_options:
      name: myOptions
      turbulence_model: wale

      divU_stress_scaling: 1.0

      options:
        - hybrid_factor:
            velocity: 0.0
            mixture_fraction: 1.0

        - alpha_upw:
            velocity: 1.0
            mixture_fraction: 1.0

        - laminar_schmidt:
            mixture_fraction: 0.9

        - turbulent_schmidt:
            mixture_fraction: 1.0

        - element_source_terms:
            momentum: [buoyancy, momentum_time_derivative]
            continuity: density_time_derivative
            mixture_fraction: mixture_fraction_time_derivative

        - user_constants:
            gravity: [0.0,-9.81,0.0]
            reference_density: 1.18

    turbulence_averaging:
      time_filter_interval: 10.0
      reynolds_averaged_variables:
       - mixture_fraction
      favre_averaged_variables:
       - mixture_fraction

    output:
      output_data_base_name: hoHelium.e
      output_frequency: 10
      output_node_set: no
      output_variables:
       - velocity
       - pressure
       - mixture_fraction
       - density
       - mixture_fraction_fa
       - mixture_fraction_ra

Time_Integrators:
  - StandardTimeIntegrator:
      name: ti_1
      start_time: 0
      termination_step_count: 10
      time_step: 1.0e-3
      time_stepping_type: adaptive
      time_step_count: 0
      second_order_accuracy: yes

      realms:
        - realm_1