#version 460

layout (location = 0) in vec3 pos;
layout (location = 1) in vec2 tex;
layout (location = 2) in vec3 normal;
layout (location = 3) in vec3 tangent;
layout (location = 4) in vec3 bitangent;

out vec3 FragPos; // ���� ��ǥ��
out vec2 TexCoord;
out vec3 FragNormal;
out mat3 TBN;

uniform mat4 modelMat;
uniform mat4 PVM;
uniform mat3 normalMat;

void main()
{
    // �� ��ȯ�� �����Ƿ� �ܼ��� ������ ��ġ�� ���
    vec4 totalPosition = vec4(pos, 1.0);

    // ���� ȸ��, ������ ��ȯ�� ����
    mat3 normalMatrix = transpose(inverse(mat3(modelMat))) * normalMat;

    gl_Position = PVM * totalPosition;

    FragPos = (modelMat * totalPosition).xyz;
    TexCoord = tex;

    // ����, ź��Ʈ, ��ź��Ʈ ���� ��ȯ
    vec3 T = normalize(normalMatrix * tangent);
    vec3 B = normalize(normalMatrix * bitangent);
    vec3 N = normalize(normalMatrix * normal);

    TBN = mat3(T, B, N);
}