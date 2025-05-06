<template>
    <div style="overflow-y:hidden;overflow-x: hidden">
        <router-view />
        <!--    头部-->
    </div>
</template>

<style>

</style>
<script>
export default {
    name:"App",
    created() {
        // 初始化用户权限状态
        const user = JSON.parse(sessionStorage.getItem('user') || '{}')
        this.$store.commit('announcement/SET_ADMIN', +user.role === 1)
    }
}
</script>