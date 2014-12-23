Simulations:
  - name: sim1
    time_integrator: ti_1
    optimizer: opt1

linear_solvers:

  - name: solve_scalar
    type: tpetra
    method: gmres
    preconditioner: sgs
    tolerance: 1e-5
    max_iterations: 50
    kspace: 50
    output_level: 0

  - name: solve_cont
    type: epetra
    method: gmres
    preconditioner: ML 
    tolerance: 1e-5
    max_iterations: 75
    kspace: 75
    output_level: 0
    recompute_preconditioner: false
    ML_options_int:
      - name: "coarse: max size"
        value: 1000
      - name: "repartition: enable"
        value: 1
      - name: "repartition: min per proc"
        value: 1000
      - name: "max levels"
        value: 10
      - name: "repartition: Zoltan dimensions"
        value: 3
      - name: "smoother: sweeps"
        value: 2
      - name: "eigen-analysis: iterations"
        value: 15
      - name: "ML output"
        value: 0 
      - name: "output"
        value: 0 
      - name: "repartition: start level"
        value: 2
    ML_options_real:
      - name: "repartition: max min ratio"
        value: 1.327
      - name: "aggregation: damping factor"
        value: 1.33333333
      - name: "aggregation: threshold"
        value: 0.02
    ML_options_string:
      - name: "aggregation: type"
        value: "Uncoupled"
      - name: "repartition: partitioner"
        value: "Zoltan"
      - name: "smoother: type"
        value: "Chebyshev"
      - name: "smoother: pre or post"
        value: "both"
      - name: "eigen-analysis: type"
        value: "power-method"

realms:

  - name: realm_1
    mesh:  jetInCrossflow_3.5M.g
    use_edges: no 
   
    time_step_control:
     target_courant: 2.0
     time_step_change_factor: 1.25
   
    equation_systems:
      name: theEqSys
      max_iterations: 3 

      solver_system_specification:
        velocity: solve_scalar
        pressure: solve_cont
        mixture_fraction: solve_scalar
 
      systems:
        - LowMachEOM:
            name: myLowMach
            max_iterations: 1
            convergence_tolerance: 1e-5

        - MixtureFraction:
            name: myZ
            max_iterations: 1
            convergence_tolerance: 1.e-2

    initial_conditions:
      - constant: ic_1
        target_name: block_1
        value:
          pressure: 0
          velocity: [295.0,0,0]
          mixture_fraction: 0.0

    material_properties:
      target_name: block_1
      specifications:

        - name: density
          type: mixture_fraction
          primary_value: 1.2679e-3
          secondary_value: 1.1807e-3

        - name: viscosity
          type: mixture_fraction
          primary_value: 1.94e-4
          secondary_value: 1.8629e-4

    boundary_conditions:

    - inflow_boundary_condition: bc_inflowJet
      target_name: jetInflow
      inflow_user_data:
        velocity: [0,1690,0]
        mixture_fraction: 1.0

    - wall_boundary_condition: bc_pipeWall
      target_name: pipeWall
      wall_user_data:
        velocity: [0,0,0]

    - inflow_boundary_condition: bc_inflowX
      target_name: crossflowInflow
      inflow_user_data:
        velocity: [295.0,0,0]
        mixture_fraction: 0.0

    - wall_boundary_condition: bc_floor
      target_name: floor
      wall_user_data:
        velocity: [0,0,0] 

    - symmetry_boundary_condition: bc_left
      target_name: leftWall
      symmetry_user_data:

    - symmetry_boundary_condition: bc_right
      target_name: rightWall
      symmetry_user_data:

    - symmetry_boundary_condition: bc_top
      target_name: topWall
      symmetry_user_data:

    - open_boundary_condition: bc_open
      target_name: open
      open_user_data:
        velocity: [0,0,0]
        pressure: 0.0
        mixture_fraction: 0.0

    solution_options:
      name: myOptions
      turbulence_model: wale
      options:

        - projected_nodal_gradient:
            pressure: element
            velocity: edge
            mixture_fraction: edge

        - hybrid_factor:
            velocity: 0.0 
            mixture_fraction: 1.0

        - alpha_upw:
            mixture_fraction: 1.0 

        - laminar_schmidt:
            mixture_fraction: 1.25

        - turbulent_schmidt:
            mixture_fraction: 1.0

        - source_terms:
            continuity: density_time_derivative

        - limiter:
            pressure: no
            velocity: no
            mixture_fraction: yes

    turbulence_averaging:
      current_time_filter: 0.0 
      time_filter_interval: 10.0
      favre_averaged_variables:
       - velocity
       - mixture_fraction

    output:
      output_data_base_name: edgeWaleJetXflowML_A.e
      output_frequency: 50 
      output_node_set: no 
      output_variables:
       - velocity
       - pressure
       - mixture_fraction
       - mixture_fraction_fa
       - velocity_fa
       - density_ra

    restart:
      restart_data_base_name: edgeWaleJetXflowML_A.rst
      output_frequency: 2000

Time_Integrators:
  - StandardTimeIntegrator:
      name: ti_1
      start_time: 0
      termination_step_count: 2
      time_step: 1.0e-6
      time_stepping_type: adaptive
      time_step_count: 0
      second_order_accuracy: yes 

      realms: 
        - realm_1
