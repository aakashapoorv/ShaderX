Shader "ShaderX/AlphaCutOut" {
	Properties{
		_Color ("Color", Color) = (1.0,1.0,1.0,1.0)
		_Height ("Cutoff Height", Range(-1.0,1.0)) = 1.0
	}
	SubShader{
		Tags { "Queue" = "Transparent" }
		Pass {
			Cull Off
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			uniform float4 _Color;
			uniform float _Height;
			
			struct vertexInput {
				float4 vertex : Position;
			};
			struct vertexOutput {
				float4 pos : SV_POSITION;
				float4 vertPos : TEXCOORD0;
			};
			
			vertexOutput vert(vertexInput v){
				vertexOutput o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.vertPos = v.vertex;
				return o;
			}
			float4 frag(vertexOutput i) : COLOR{
				if(i.vertPos.y > _Height){
					discard;
				}
				return _Color;
			}
			
			ENDCG
		}
	}
	Fallback "Diffuse"
}