// Vertex shader

// Define the output structure for the vertex shader
struct VertexOutput {
    @builtin(position) clip_position: vec4<f32>, // The final position of the vertex in clip space (after transformations)
    @location(0) color: vec3<f32>,               // The RGB color data that will be passed to the fragment shader
};

// VertexOutput Struct: This struct is the output format of the vertex shader. 
// The clip_position represents the vertex's position after it has been transformed into clip space 
// (a coordinate space used for rendering), and color is a 3-component vector for RGB color data. 
// The annotations @builtin(position) and @location(0) specify the semantics for the GPU, indicating 
// clip_position as the vertex position and color as a variable to pass along to the fragment shader.

// Main function for the vertex shader, designated with @vertex
@vertex
fn vs_main(
    @builtin(vertex_index) in_vertex_index: u32, // Built-in attribute providing the index of the vertex currently being processed
) -> VertexOutput {                              // Returns a `VertexOutput` struct containing position and color data
    var out: VertexOutput;                       // Declare an instance of `VertexOutput` to store output data

    // Set positions and colors for each vertex based on its index
    if (in_vertex_index == 0u) {                 // First vertex (top of the triangle)
        out.clip_position = vec4<f32>(0.0, 0.5, 0.0, 1.0); // Top vertex position in clip space
        out.color = vec3<f32>(1.0, 0.0, 0.0);              // Assign red color
    } else if (in_vertex_index == 1u) {          // Second vertex (bottom-left of the triangle)
        out.clip_position = vec4<f32>(-0.5, -0.5, 0.0, 1.0); // Bottom-left position in clip space
        out.color = vec3<f32>(0.0, 1.0, 0.0);                 // Assign green color
    } else {                                     // Third vertex (bottom-right of the triangle)
        out.clip_position = vec4<f32>(0.5, -0.5, 0.0, 1.0);  // Bottom-right position in clip space
        out.color = vec3<f32>(0.0, 0.0, 1.0);                 // Assign blue color
    }

    return out;                                  // Return the position and color to the GPU pipeline
}

// vs_main Function (Vertex Shader): This function is responsible for setting up each vertex's position and color based on its index:

// @builtin(vertex_index) in_vertex_index: WGPU provides this built-in attribute to identify the index of each vertex. 
// It’s used to determine the position and color of each vertex.
// The position of each vertex is set with vec4<f32>(x, y, z, w). The w component is 1.0 to indicate a position rather 
// than a direction in homogeneous coordinates.
// Each vertex color is assigned to either red, green, or blue, creating a gradient across the triangle in the fragment shader.

// Fragment shader

// Main function for the fragment shader, designated with @fragment
@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
    // Use the color data passed from the vertex shader
    return vec4<f32>(in.color, 1.0);             // Set the fragment color, including an alpha value of 1.0 for full opacity
}

// fs_main Function (Fragment Shader): The fragment shader receives interpolated values from the vertex shader 
// (like position and color) and determines the color of each fragment (pixel) within a triangle:

// in: VertexOutput: The interpolated data from the vertex shader, containing color information.
// vec4<f32>(in.color, 1.0): This line combines the RGB color from VertexOutput with an alpha value of 1.0, which signifies full opacity.
