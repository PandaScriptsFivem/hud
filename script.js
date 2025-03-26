window.addEventListener('message', (event) => {
    const data = event.data;

    if (data.type === 'updateHud') {
        document.getElementById('job').innerText = data.job
        if (data.health < 0) {
            document.getElementById('health-bar').style.height = `0%`;

        } else {
            document.getElementById('health-bar').style.height = `${data.health}%`;
        }
        if (data.armor != false) {
            document.getElementById('armor-bar').style.height = `${data.armor}%`;
            document.getElementById('armor-box').style.display = "flex";
        } else {
            document.getElementById('armor-box').style.display = "none";
        }
        document.getElementById('hunger-bar').style.height = `${data.hunger}%`;
        document.getElementById('thirst-bar').style.height = `${data.thirst}%`;

        if (data.stamina != null) {
            document.getElementById('stamina-bar').style.height = `${ data.stamina}%`;
            document.getElementById('stamina-box').style.display = "flex";
        } else {
            document.getElementById('stamina-box').style.display = "none";
        }
        if (data.mic == true) {
            mic.style.color = "yellow"
        } else {
            mic.style.color = "white"
        }
    }

    if (data.type === 'toggleHud') {
        const hud = document.getElementById('hud-container');
        const jobhud = document.getElementById('hud-jobfent');
    
        if (hud && jobhud) {
            if (data.state) {
                hud.style.opacity = "1";
                hud.style.transform = "translate(-50%, 0)";
                jobhud.style.opacity = "1";
                jobhud.style.transform = "translateY(0)";
                mic.style.opacity = "1"
            } else {
                hud.style.opacity = "0";
                hud.style.transform = "translate(-50%, 10px)";
                jobhud.style.opacity = "0";
                jobhud.style.transform = "translateY(-10px)";
                mic.style.opacity = "0"
            }
        }
    }
    
    
});
