Shader "Unity Shaders Book/Diffuse Vertex-Level"
{
	Properties
	{
		_Diffuse("Diffuse" , Color) = (1,1,1,1)
	}
	SubShader
	{
		Pass
		{
			// Tags {"LightMode" = "ForwardBase"}
			Tags{ "RenderType" = "Opaque" }  
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			#include "Lighting.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 normal : NORMAL;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float3 color : Color;
			};

			fixed4 _Diffuse;
			v2f vert (appdata v)
			{
				v2f o;
				//Transform the vertex from object space to projection space
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				//Get ambient term
				fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;
				//Transform the normal fram object space to world space
				fixed3 worldNormal = normalize(mul(v.normal , (float3x3)_World2Object));
				//Get the light direction in world space
				fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);
				//Compute diffuse term
				fixed3 diffuse = saturate(dot(worldNormal , worldLight));
				o.color = ambient + diffuse;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				return fixed4(1 , 1 , 1 , 1);
			}
			ENDCG
		}
	}
}
