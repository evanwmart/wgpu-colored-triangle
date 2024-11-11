// Vertex shader

struct VertexOutput {
    @builtin(position) clip_position: vec4<f32>,
    @location(0) color: vec3<f32>, // Pass color data to fragment shader
};

@vertex
fn vs_main(
    @builtin(vertex_index) in_vertex_index: u32,
) -> VertexOutput {
    var out: VertexOutput;

    // Set positions and colors for each vertex
    if (in_vertex_index == 0u) {
        out.clip_position = vec4<f32>(0.0, 0.5, 0.0, 1.0); // Top vertex
        out.color = vec3<f32>(1.0, 0.0, 0.0); // Red
    } else if (in_vertex_index == 1u) {
        out.clip_position = vec4<f32>(-0.5, -0.5, 0.0, 1.0); // Bottom-left vertex
        out.color = vec3<f32>(0.0, 1.0, 0.0); // Green
    } else {
        out.clip_position = vec4<f32>(0.5, -0.5, 0.0, 1.0); // Bottom-right vertex
        out.color = vec3<f32>(0.0, 0.0, 1.0); // Blue
    }

    return out;
}

// Fragment shader

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
    // Use the interpolated color from the vertex shader
    return vec4<f32>(in.color, 1.0);
}
